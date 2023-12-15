//
//  day15.swift
//  AoC2023
//
//  Created by Marcel Mravec on 15.12.2023.
//

import Foundation

enum Day15 {
    static func run() {
        let input1 = readFile("day15.input")
        let input = input1.components(separatedBy: ",")
        print(day15Part1(input))
        print(day15Part2(input1))
    }
}

func day15Part1(_ input: [String]) -> Int {
    var currentValue: [Int] = Array(repeating: 0, count: input.count)
    for (index, item) in input.enumerated() {
        currentValue[index] = hashValue(item)
    }
    return currentValue.reduce(0, +)
}

func day15Part2(_ input: String) -> Int {
    
    return 2
}

func hashValue(_ input: String) -> Int {
    var currentValue = 0
    _ = input.map { char in
        if char == "\n" { return currentValue }
        currentValue += Int(char.asciiValue ?? 0)
        currentValue *= 17
        currentValue = currentValue % 256
        return currentValue
    }
    return currentValue
}
