//
//  day01.swift
//  AoC2023
//
//  Created by Marcel Mravec on 01.12.2023.
//

import Foundation

enum Day01 {
    static func run() {
        let input1 = readFile("day01.input")
        
        let result = day01Part1(input1)
        print(result)
        print(day01Part2(input1))
    }
}

func day01Part1(_ input: String) -> Int {
    let lines = input.lines
    return lines.reduce(0) { sum, line in
        let digits = line.map { $0 }.compactMap { Int(String($0)) }
        return sum + (digits.first ?? 0) * 10 + (digits.last ?? 0)
    }
}

func day01Part2(_ input: String) -> Int {
    let textNumbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    func convertToNumeric(_ input: String) -> Int? {
        if let numericValue = Int(input) {
            return numericValue
        }
        if let index = textNumbers.firstIndex(of: input) {
            return index + 1
        }
        return nil
    }
    
    
    func firstNumber(_ line: String) -> Int {
//        print("Line to find number is \(line)")
        var firstSubstring = [String: Int]()
        for substring in textNumbers {
            if let range = line.range(of: substring) {
//                print("Substring found in range: \(range.lowerBound) to \(range.upperBound)")
                let startIndex = line.distance(from: line.startIndex, to: range.lowerBound)
                let endIndex = line.distance(from: line.startIndex, to: range.upperBound)
//                print("Substring found at indices: \(startIndex) to \(endIndex)")
                let foundSubstring = line[range]
//                print("Found substring: \(foundSubstring)")
                
                firstSubstring[String(foundSubstring)] = startIndex
            }
        }
//        print("First substring is \(firstSubstring)")
        if  let minKeyValuePair = firstSubstring.min(by: { $0.value < $1.value }) {
            let minKey = minKeyValuePair.key
            let minValue = minKeyValuePair.value
//            print("Min value is \(minValue)")
            let foundInt = Int(minKey) ?? 0
            let convertedNumber = convertToNumeric(String(minKey)) ?? 0
            return minKey.count > 1 ? convertedNumber : foundInt
        }
        return  0
    }
    
    func lastNumber(_ line: String) -> Int {
//        print("Line to find number is \(line)")
    
        var lastSubstring = [String: Int]()
        for substring in textNumbers {
            var lastIndex = 0
            var startIndex = line.startIndex
            
            while let range = line[startIndex...].range(of: substring) {
                let substringStartIndex = line.distance(from: line.startIndex, to: range.lowerBound)
                lastIndex = substringStartIndex + substring.count
                startIndex = range.upperBound
            }
            
            if lastIndex > 0 {
                lastSubstring[substring] = lastIndex
            }
        }
//        print("Last substring is \(lastSubstring)")
        if let maxKeyValuePair = lastSubstring.max(by: { $0.value < $1.value }) {
            let maxKey = maxKeyValuePair.key
            let maxValue = maxKeyValuePair.value
//            print("Max value is \(maxValue)")
            let foundInt = Int(maxKey) ?? 0
            let convertedNumber = convertToNumeric(String(maxKey)) ?? 0
            return maxKey.count > 1 ? convertedNumber : foundInt
        }
        return  0
    }
    
    let lines = input.lines
    let x = lines.map { firstNumber($0) }
//    print("First numbers are \(x)")
    let y = lines.map { lastNumber($0) }
//    print("Last numbers are \(y)")
    
    let sumX = x.reduce(0, { partialResult, number in
        partialResult + number * 10
    })
    let sumY = y.reduce(0, { partialResult, number in
        partialResult + number
    })
    return sumX + sumY
}
