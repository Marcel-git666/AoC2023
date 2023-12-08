//
//  dayéš.swift
//  AoC2023
//
//  Created by Marcel Mravec on 02.12.2023.
//

import Foundation

import Foundation

enum Day03 {
    static func run() {
        let input1 = readFile("day03.test")
        print(input1)
        let result = day03Part1(input1)
        print(result)
        print(day03Part2(input1))
    }
}

func day03Part1(_ input: String) -> Int {
    let lines = input.lines
    print(lines)
    let symbols: CharacterSet = CharacterSet(charactersIn: "!@#$%^&*+/=-")
    var partsArray = [[Part]]()
    var connectedNumbers = [Int]()
    
    for (_, line) in lines.enumerated() {
        var row = [Part]()
        for (_, character) in line.enumerated() {
            let isNumber = character.isNumber
            let isSymbol = symbols.contains(character.unicodeScalars.first!)
            
            let isConnected = false
            let part = Part(
                isConnected: isConnected,
                isNumber: isNumber,
                isSymbol: isSymbol,
                value: character
            )
            row.append(part)
        }
        partsArray.append(row)
    }
    
    // Print the result using CustomStringConvertible
    for row in partsArray {
        print(row.map { $0.description }.joined(), terminator: "\n")
    }
    
    for (rowIndex, row) in partsArray.enumerated() {
        var lastNumber: Int?
        for (colIndex, _) in row.enumerated() {
            if row[colIndex].isNumber {
                var isConnected = false
                
                if let lastNumber = lastNumber, colIndex > 0, row[colIndex - 1].isConnected {
                    print(lastNumber)
                    isConnected = true
                } else if (rowIndex > 0 && symbols.contains(partsArray[rowIndex - 1][colIndex].value.unicodeScalars.first!)) ||
                            (rowIndex < partsArray.count - 1 && symbols.contains(partsArray[rowIndex + 1][colIndex].value.unicodeScalars.first!)) ||
                            (colIndex > 0 && symbols.contains(partsArray[rowIndex][colIndex - 1].value.unicodeScalars.first!)) ||
                            (colIndex < row.count - 1 && symbols.contains(partsArray[rowIndex][colIndex + 1].value.unicodeScalars.first!)) ||
                            (rowIndex > 0 && colIndex > 0 && symbols.contains(partsArray[rowIndex - 1][colIndex - 1].value.unicodeScalars.first!)) ||
                            (rowIndex > 0 && colIndex < row.count - 1 && symbols.contains(partsArray[rowIndex - 1][colIndex + 1].value.unicodeScalars.first!)) ||
                            (rowIndex < partsArray.count - 1 && colIndex > 0 && symbols.contains(partsArray[rowIndex + 1][colIndex - 1].value.unicodeScalars.first!)) ||
                            (rowIndex < partsArray.count - 1 && colIndex < row.count - 1 && symbols.contains(partsArray[rowIndex + 1][colIndex + 1].value.unicodeScalars.first!)) {
                    isConnected = true
                }
                
                partsArray[rowIndex][colIndex].isConnected = isConnected
            }
            lastNumber = nil
        }
        
    }
    
    for (rowIndex, row) in partsArray.enumerated() {
        var lastNumber: Int?
        var canConnect = false
        for (colIndex, _) in row.enumerated() {
            if lastNumber != nil {
                if row[colIndex].isNumber {
                    lastNumber = 10 * lastNumber! + Int(String(row[colIndex].value))!
                    if partsArray[rowIndex][colIndex].isConnected {
                        canConnect = true
                    }
                } else if canConnect {
                    connectedNumbers.append(lastNumber!)
                    lastNumber = nil
                    canConnect = false
                } else {
                    lastNumber = nil
                    canConnect = false
                }
            } else if lastNumber == nil && row[colIndex].isNumber {
                lastNumber = Int(String(row[colIndex].value))
                if partsArray[rowIndex][colIndex].isConnected {
                    canConnect = true
                }
            }
        }
        if partsArray[rowIndex][row.count-1].isNumber {
            if canConnect {
                connectedNumbers.append(lastNumber!)
                lastNumber = nil
                canConnect = false
            } else {
                lastNumber = nil
                canConnect = false
            }
        }
    }
    
    // Print the connected numbers array
    print("Connected Numbers: \(connectedNumbers)")
    
    let sum = connectedNumbers.reduce(0, +)
    
    
    return sum
}

func day03Part1AnotherSolution(_ input1: String) -> Int {
    let input = input1.lines
    var res = 0
    for (row, line) in input.enumerated() {
        var col = 0
        while col < line.count {
            let c = line[line.index(line.startIndex, offsetBy: col)]
            if c.isNumber {
                let numEndIndex = line.index(line.startIndex, offsetBy: col)
                let num = String(line[numEndIndex...])
                    .prefix(while: { $0.isNumber })
                if isSymbolAround(row: row, col: col, colOffset: num.count, grid: input) {
                    res += Int(num) ?? 0
                }
                col += num.count
            } else {
                col += 1
            }
        }
    }
    
    return res
}

private func isSymbolAround(row: Int, col: Int, colOffset: Int, grid: [String], symbol: Character? = nil) -> Bool {
    for dr in -1...1 {
        if row + dr < 0 || row + dr >= grid.count {
            continue
        }
        for dc in -1...colOffset {
            if col + dc < 0 || col + dc >= grid[row + dr].count {
                continue
            }
            let s = grid[row + dr][grid[row + dr].index(grid[row + dr].startIndex, offsetBy: col + dc)]
            if (symbol != nil && s == symbol) || s != "." && !s.isNumber {
                return true
            }
        }
    }
    
    return false
}

struct Part: CustomStringConvertible {
    var isConnected: Bool
    var isNumber: Bool
    var isSymbol: Bool
    var value: Character
    
    var description: String {
        "(\(isConnected ? "T": "F"), \(isNumber ? "T": "F"), \(isSymbol ? "T": "F"), \(value))"
    }
}

func day03Part2(_ input1: String) -> Int {
    let symbols = "!@#$%^&*+/=-"
    var result = 0
    let lines = input1.lines
    let grid = lines.map { Array($0) }
    print(grid)
    for i in 0..<grid.count {
        for j in 0..<grid[i].count {
            let value = grid[i][j]
            if symbols.contains(value) {
                let numbers = areTwoNumbersAround(i: i, j: j, grid: grid)
                if numbers.count == 2 {
                    result += numbers[0]*numbers[1]
                }
            }
        }
    }
    return result
}

func areTwoNumbersAround(i: Int, j: Int, grid: [[String.Element]]) -> [Int] {
    var numbersAround: [Int] = []
    for row in i-1...i+1 {
        if row < 0 || row > grid.count {
            continue
        }
        for col in j-1...j+1 {
            var numberToAdd: String = ""
            if col < 0 || col > grid.count {
                continue
            }
            if grid[row][col].isNumber {
                var search = col
                while search > 0 && grid[row][search].isNumber   {
                    search -= 1
                }
//                if search < 0 {
//                    search = 0
//                }
                while search < grid.count && grid[row][search].isNumber  {
                    print("I have found this number \(numberToAdd) and should add \(grid[row][search])")
                    numberToAdd += String(grid[row][search])
                    search += 1
                }
                if let number = Int(numberToAdd) {
                    numbersAround.append(number)
                }
                print("I have added \(numberToAdd)")
                numberToAdd = ""
            }
            
        }
    }
    return numbersAround
}
