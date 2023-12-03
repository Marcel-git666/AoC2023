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
        let input1 = readFile("day03.input")
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
    
    for (i, line) in lines.enumerated() {
        var row = [Part]()
        for (j, character) in line.enumerated() {
            let isNumber = character.isNumber
            let isSymbol = symbols.contains(character.unicodeScalars.first!)
            
            var isConnected = false
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
        for (colIndex, part) in row.enumerated() {
            if row[colIndex].isNumber {
                var isConnected = false

                if let lastNumber = lastNumber, colIndex > 0, row[colIndex - 1].isConnected {
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
        for (colIndex, part) in row.enumerated() {
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
    
    func day03Part2(_ input: String) -> Int {
        
        return 2
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
