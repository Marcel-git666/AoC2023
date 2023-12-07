//
//  day07.swift
//  AoC2023
//
//  Created by Marcel Mravec on 04.12.2023.
//

import Foundation

enum Day07 {
    static func run() {
        let input1 = readFile("day07.input")
        
       
        print(day07Part1(input1))
        print(day07Part2(input1))
    }
}

func day07Part1(_ input: String) -> Int {
    let cardStrength = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
    func handOrder(_ hand: String) -> Int {
        let cardIndices = hand.compactMap { cardStrength.firstIndex(of: String($0)) }
        return cardIndices.reduce(0, { $0 * 100 + $1 })
    }
    
    let lines = input.lines
    let handsAndBids = lines.compactMap { line -> (String, String, Int)? in
        let components = line.components(separatedBy: " ")
        if components.count == 2, let bid = Int(components[1]) {
            return (components[0], calculateCharacterFrequencies(components[0]), bid)
        }
        return nil
    }
    print("Tupples: \(handsAndBids)")
    let sorted: [(String, String, Int)] = handsAndBids.sorted { (tuple1, tuple2) in
        if tuple1.1 < tuple2.1 {
            return true
        } else if tuple1.1 == tuple2.1 {
            return handOrder(tuple1.0) < handOrder(tuple2.0)
        }
        return false
    }

    return sorted.enumerated().reduce(0) { (accumulatedResult, tuple) in
        let (index, element) = tuple
        return accumulatedResult + (element.2 * (index + 1))
    }
}

func day07Part2(_ input: String) -> Int {
    let cardStrength = ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"]
    func handOrder(_ hand: String) -> Int {
        let cardIndices = hand.compactMap { cardStrength.firstIndex(of: String($0)) }
        return cardIndices.reduce(0, { $0 * 100 + $1 })
    }
    let lines = input.lines
    let handsAndBids = lines.compactMap { line -> (String, String, Int)? in
        let components = line.components(separatedBy: " ")
        if components.count == 2, let bid = Int(components[1]) {
            return (components[0], calculateJokerCharacterFrequencies(components[0]), bid)
        }
        return nil
    }
    print("Tupples: \(handsAndBids)")
    let sorted: [(String, String, Int)] = handsAndBids.sorted { (tuple1, tuple2) in
        if tuple1.1 < tuple2.1 {
            return true
        } else if tuple1.1 == tuple2.1 {
            return handOrder(tuple1.0) < handOrder(tuple2.0)
        }
        return false
    }
    print("Sorted: ", sorted)
    return sorted.enumerated().reduce(0) { (accumulatedResult, tuple) in
        let (index, element) = tuple
        return accumulatedResult + (element.2 * (index + 1))
    }
}

func calculateJokerCharacterFrequencies(_ input: String) -> String {
    
    if input == "JJJJJ" {
        return "5"
    }
    var removedJokers = input
    removedJokers.removeAll { $0 == "J" }
    print(removedJokers)
    var frequencyDict = removedJokers.reduce(into: [:]) { (dict, char) in
        dict[char, default: 0] += 1
    }
    let sortedFrequencies = frequencyDict.sorted { $0.value > $1.value }
    if let highestFrequency = sortedFrequencies.first {
            frequencyDict[highestFrequency.key]! += input.count - removedJokers.count
        }
    
    return frequencyDict
        .sorted { $0.value > $1.value }
        .map { String($0.value) }
        .joined()
}

func calculateCharacterFrequencies(_ input: String) -> String {
    let frequencyDict = input.reduce(into: [:]) { (dict, char) in
        dict[char, default: 0] += 1
    }

    let sortedFrequencies = frequencyDict.sorted { $0.value > $1.value }
    return sortedFrequencies.map { String($0.value) }.joined()
}
