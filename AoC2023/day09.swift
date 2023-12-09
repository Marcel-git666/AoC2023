//
//  day09.swift
//  AoC2023
//
//  Created by Marcel Mravec on 04.12.2023.
//

import Foundation

enum Day09 { // 1853145120 je spatne je to moc a 997894315 je malo
    static func run() {
        let input1 = readFile("day09.input")
        let lines = input1.lines.map { $0.components(separatedBy: " ").compactMap { Int($0) } }
        print(lines)
        
        
        print("Part 1: ", day09Part1(lines))
        print("Part 2: ", day09Part2(lines))
    }
}

func predict(_ line: [Int]) -> Int {
    var currentLine = line
    var matrix: [[Int]] = [[]]
    var matrixLine: [Int] = []
    matrix.append(currentLine)
    print("Matrix after first line: \(matrix)")
    print("Current line is \(currentLine)")
    while !currentLine.allSatisfy({ $0 == 0 }) {
        var i = 1
        while  i < currentLine.count {
            let item = currentLine[i] - currentLine[i-1]
            print(item)
            matrixLine.append(item)
            i += 1
        }
        print("MatrixLine is: \(matrixLine)")
        matrix.append(matrixLine)
        currentLine = matrixLine
        matrixLine = []
    }
    print(matrix)
    let result = matrix.map { row in
        row.last ?? 0
    }.reduce(0, +)

    print("Sum is: \(result)")
    return result
}

func day09Part1(_ input: [[Int]]) -> Int {
    input.reduce(into: 0) { partialResult, line in
        partialResult += predict(line)
    }
}


func predictBefore(_ line: [Int]) -> Int {
    var currentLine = line
    var matrix: [[Int]] = [[]]
    var matrixLine: [Int] = []
    matrix.append(currentLine)
    print("Matrix after first line: \(matrix)")
    matrix.removeFirst()
    print("Matrix after first line: \(matrix)")
    print("Current line is \(currentLine)")
    while !currentLine.allSatisfy({ $0 == 0 }) {
        var i = 1
        while  i < currentLine.count {
            let item = currentLine[i] - currentLine[i-1]
            print(item)
            matrixLine.append(item)
            i += 1
        }
        print("MatrixLine is: \(matrixLine)")
        matrix.append(matrixLine)
        currentLine = matrixLine
        matrixLine = []
    }
    print("Matrix before counting: ", matrix)
    let result = matrix.enumerated().map { (index, line) in
        (index % 2 == 0 ? 1 : -1) * (line.first ?? 0)
    }.reduce(0, +)

    print("Sum is: \(result)")
    return result
}


func day09Part2(_ input: [[Int]]) -> Int {
    input.reduce(into: 0) { partialResult, line in
        partialResult += predictBefore(line)
    }
}
