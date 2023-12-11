//
//  day10.swift
//  AoC2023
//
//  Created by Marcel Mravec on 04.12.2023.
//

import Foundation

enum Day10 {
    static func run() {
        let input1 = readFile("day10.input")
        let input = input1.lines.map({ $0.map({String($0)})})
        print(day10Part1(input))
        print(day10Part2(input1))
    }
}

func day10Part1(_ input: [[String]]) -> Int {
    print(input)
    var startRow: Int = 0
    var startCol: Int = 0
    var previousRow = -1
    var previousCol = -1
    var currentRow = -1
    var currentCol = -1
    for (rowIndex, row) in input.enumerated() {
        if hasCharacterS(row: row) {
            print("Character 'S' found at row: \(rowIndex)")
            print("Row has \(row.count) items.")
            startRow = rowIndex
            var colIndex = 0
            while colIndex < row.count {
                if row[colIndex] == "S" {
                    print("Character 'S' found at column: \(colIndex)")
                    startCol = colIndex
                    break
                }
                colIndex += 1
            }
            startCol = colIndex
            break
        }
    }
    print("Character S is on row, col: \(startRow) \(startCol)")
    print("Input has \(input.count) items.")
    
    previousCol = startCol
    previousRow = startRow
    currentCol = startCol
    currentRow = startRow
    var placesToExplore: [Point] = []
    var exploredPlaces: [Point] = []
    
    if startCol > 0 {
        placesToExplore.append(Point(row: startRow, col: (startCol - 1)))
    }
    if startCol < input.count {
        placesToExplore.append(Point(row: startRow, col: (startCol + 1)))
    }
    if startRow > 0 {
        placesToExplore.append(Point(row: startRow - 1, col: startCol))
    }
    if startRow < input.count {
        placesToExplore.append(Point(row: startRow + 1, col: startCol))
    }
    
    print("Places to explore: \(placesToExplore)")
    for place in placesToExplore {
        print("Starting at position row: \(place.row) and col: \(place.col)")
        currentCol = place.col
        currentRow = place.row
        while Set(exploredPlaces).count == exploredPlaces.count {
            print("Current character is \(input[currentRow][currentCol]) [\(currentRow)][\(currentCol)]")
            switch input[currentRow][currentCol] {
            case "|": print("Going North or South")
                if currentRow > previousRow {
                    print("Going South")
                    if currentCol < input.count {
                        previousRow = currentRow
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentRow += 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                } else {
                    print("Going North")
                    if currentRow > 0 {
                        previousRow = currentRow
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentRow -= 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                }
            case "-": print("Going East or West")
                if currentCol > previousCol {
                    print("Going East")
                    if currentCol < input.count {
                        previousCol = currentCol
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentCol += 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                } else {
                    print("Going West")
                    if currentCol > 0 {
                        previousCol = currentCol
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentCol -= 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                }
            case "L": print("Going East or North")
                if currentCol == previousCol {
                    print("Going East")
                    if currentCol < input.count {
                        previousCol = currentCol
                        previousRow = currentRow
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentCol += 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                } else {
                    print("Going North")
                    if currentRow > 0 {
                        previousRow = currentRow
                        previousCol = currentCol
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentRow -= 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                }
            case "J": print("Going West or North")
                if currentCol == previousCol {
                    print("Going West")
                    if currentCol > 0 {
                        previousCol = currentCol
                        previousRow = currentRow
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentCol -= 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                } else {
                    print("Going North")
                    if currentRow > 0 {
                        previousRow = currentRow
                        previousCol = currentCol
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentRow -= 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                }
            case "7": print("Going West or South")
                if currentCol == previousCol {
                    print("Going West")
                    if currentCol > 0 {
                        previousCol = currentCol
                        previousRow = currentRow
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentCol -= 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                } else {
                    print("Going South")
                    if currentRow < input.count {
                        previousRow = currentRow
                        previousCol = currentCol
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentRow += 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                }
            case "F": print("Going East or South")
                if currentCol == previousCol {
                    print("Going East")
                    if currentCol <  input.count {
                        previousCol = currentCol
                        previousRow = currentRow
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentCol += 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                } else {
                    print("Going South")
                    if currentRow < input.count {
                        previousRow = currentRow
                        previousCol = currentCol
                        exploredPlaces.append(Point(row: currentRow, col: currentCol))
                        currentRow += 1
                    } else {
                        print("We are going out of grid")
                        exploredPlaces = []
                        break
                    }
                }
            case "S": print("We are on starting position")
                if exploredPlaces.count % 2 == 0 {
                    return exploredPlaces.count / 2 + 1
                } else {
                    return exploredPlaces.count / 2 + 1
                }
            case ".": print("We hit the ground")
            default: print("Something is wrong")
                
            }
            if exploredPlaces.isEmpty {
                break
            }
            print("Explored places are: \(exploredPlaces.count)")
            if Set(exploredPlaces).count != exploredPlaces.count {
                print("Opakujici se body \n \(exploredPlaces.description)")
                exploredPlaces = []
                break
            }
        }
    }
    return 1
}

func day10Part2(_ input: String) -> Int {
    
    return 2
}

func hasCharacterS(row: [String]) -> Bool {
    for character in row {
        if character == "S" {
            return true
        }
    }
    return false
}


struct Point: Hashable, CustomStringConvertible {
    var row: Int
    var col: Int
    
    var description: String {
        return "[\(row)][\(col)]"
    }
}
