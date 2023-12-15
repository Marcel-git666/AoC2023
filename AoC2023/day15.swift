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
        let input = input1.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        print(day15Part1(input))
        print(day15Part2(input))
    }
}

func day15Part1(_ input: [String]) -> Int {
    var currentValue: [Int] = Array(repeating: 0, count: input.count)
    for (index, item) in input.enumerated() {
        currentValue[index] = hashValue(item)
    }
    return currentValue.reduce(0, +)
}

func day15Part2(_ input: [String]) -> Int {
    print(input)
    var boxOfLenses = Array(repeating: [String](), count: 256)
    for item in input {
        switch item.suffix(1) {
        case "-": let hash = hashValue(String(item.prefix(item.count - 1)))
            print("- \(item) hash:", hash)
            for (i, lens) in boxOfLenses[hash].enumerated() {
                if lens.prefix(lens.count - 2) == item.prefix(item.count - 1) {
                    boxOfLenses[hash].remove(at: i)
                }
            }
        default: let hash = hashValue(String(item.prefix(item.count - 2)))
            print("= \(item) hash:", hash)
            var valueFound = false
            for (i, lens) in boxOfLenses[hash].enumerated() {
                if lens.prefix(item.count - 2) == item.prefix(item.count - 2) {
                    boxOfLenses[hash].insert(item, at: i)
                    boxOfLenses[hash].remove(at: i+1)
                    valueFound = true
                    break
                } else {
                    valueFound = false
                }
            }
            if !valueFound {
                boxOfLenses[hash].append(item)
            }
            
        }
    }
    print(boxOfLenses)
    var finalValue = 0
    for (i, row) in boxOfLenses.enumerated() {
        for (j, col) in boxOfLenses[i].enumerated() {
            finalValue += (i+1) * (j+1) * (Int(String((col.suffix(1)))) ?? 0)
        }
    }
    return finalValue
}

func hashValue(_ input: String) -> Int {
    var currentValue = 0
    _ = input.map { char in
        currentValue += Int(char.asciiValue ?? 0)
        currentValue *= 17
        currentValue = currentValue % 256
        return currentValue
    }
    return currentValue
}
