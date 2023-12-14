//
//  day11.swift
//  AoC2023
//
//  Created by Marcel Mravec on 10.12.2023.
//

import Foundation

enum Day11 {
    static func run() {
        let input1 = readFile("day11.input")
        let input = input1.lines.map({ $0.map({String($0)})})
        print(day11Part1(input))
        print(day11Part2(input))
    }
}

func day11Part1(_ input: [[String]]) -> Int {
    let expandedSpace = expand(input)
    var galaxies: [Point]
    galaxies = findGalaxies(in: expandedSpace)
    
    return createDistances(galaxies)
}

func day11Part2(_ input: [[String]]) -> Int {
    var galaxies: [Point]
    galaxies = findFarGalaxies(in: input)
    
    return createDistances(galaxies)
}

func createDistances(_ galaxies: [Point]) -> Int {
    var distances = [Int]()

    // Create distances for all pairs
    for i in 0..<galaxies.count {
        
        for j in (i + 1)..<galaxies.count {
            let dist = distance(galaxy1: galaxies[i], galaxy2: galaxies[j])
            distances.append(dist)
        }
    }

    return distances.reduce(0, +)
}


func distance(galaxy1: Point, galaxy2: Point) -> Int {
    abs(galaxy1.row - galaxy2.row) + abs(galaxy1.col - galaxy2.col)
}

func findGalaxies(in space: [[String]]) -> [Point] {
    var galaxies: [Point] = []
    for (rowIndex, row) in space.enumerated() {
        for (colIndex, _) in row.enumerated() {
                if space[rowIndex][colIndex] == "#" {
                    galaxies.append(Point(row: rowIndex, col: colIndex))
                }
            }
        }
    return galaxies
}

func findFarGalaxies(in space: [[String]]) -> [Point] {
    var galaxies: [Point] = []
    var rowsToExpand = [Int]()
    var colsToExpand = [Int]()
    for (index, row) in space.enumerated() {
        if row.allSatisfy({ $0 == "." }) {
            rowsToExpand.append(index)
        }
    }
    
    for colIndex in 0..<space[0].count {
        let column = space.map { $0[colIndex] }
        if column.allSatisfy({ $0 == "." }) {
            colsToExpand.append(colIndex)
        }
    }
    for (rowIndex, row) in space.enumerated() {
            for (colIndex, _) in row.enumerated() {
                if space[rowIndex][colIndex] == "#" {
                    var rowExpanded: Int = 0
                    var colExpanded: Int = 0
//                    print("Galaxy found at \(rowIndex):\(colIndex)")
                    if rowsToExpand.filter({$0 < rowIndex}).count != 0 {
                        rowExpanded = rowIndex + rowsToExpand.filter({$0 < rowIndex}).count * 999_999
                    } else {
                        rowExpanded = rowIndex
                    }
                    if colsToExpand.filter({$0 < colIndex}).count != 0 {
                        colExpanded = colIndex + colsToExpand.filter({$0 < colIndex}).count * 999_999
                    } else {
                        colExpanded = colIndex
                    }
//                    print("Row goes from \(rowIndex) to \(rowExpanded)")
//                    print("Col goes from \(colIndex) to \(colExpanded)")
                    galaxies.append(Point(row: rowExpanded, col: colExpanded))
                }
            }
        }
    return galaxies
}



func expand(_ space: [[String]]) -> [[String]] {
    var rowsToExpand = [Int]()
    var colsToExpand = [Int]()
    
    for (index, row) in space.enumerated() {
        if row.allSatisfy({ $0 == "." }) {
            rowsToExpand.append(index)
        }
    }
    
    for colIndex in 0..<space[0].count {
        let column = space.map { $0[colIndex] }
        if column.allSatisfy({ $0 == "." }) {
            colsToExpand.append(colIndex)
        }
    }
    
    var expandedSpace = space
    for rowIndex in rowsToExpand.reversed() {
        expandedSpace.insert(expandedSpace[rowIndex], at: rowIndex)
    }
    
    for colIndex in colsToExpand.reversed() {
        for rowIndex in 0..<expandedSpace.count {
            expandedSpace[rowIndex].insert(expandedSpace[rowIndex][colIndex], at: colIndex)
        }
    }
    
    return expandedSpace
}

