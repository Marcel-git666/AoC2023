//
//  daz04.swift
//  AoC2023
//
//  Created by Marcel Mravec on 02.12.2023.
//

import Foundation

import Foundation

enum Day04 {
    static func run() {
        let input1 = readFile("day04.input")
        
        let result = day04Part1(input1)
        print(result)
        print(day04Part2(input1))
    }
}

func day04Part1(_ input: String) -> Int {
    let lines = input.lines
    var price = [Int]()
    for line in lines {
        let parts = line.components(separatedBy: ":").dropFirst()
        let ticket = parts[1].components(separatedBy: "|")
        let winningNumbers = ticket[0].components(separatedBy: " ").compactMap { Int($0) }
        let winningNumbersSet = Set(winningNumbers)
        let myNumbers = ticket[1].components(separatedBy: " ").compactMap { Int($0) }
        let myNumbersSet = Set(myNumbers)
        let repeatingNumbers = winningNumbersSet.intersection(myNumbersSet)
        if repeatingNumbers.count > 0 {
            let value = pow(2, Double(repeatingNumbers.count - 1))
            price.append(Int(value))
        }
    }
    return price.reduce(0, +)
}

func day04Part2(_ input: String) -> Int {
    
    return 2
}
