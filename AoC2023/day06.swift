//
//  day06.swift
//  AoC2023
//
//  Created by Marcel Mravec on 04.12.2023.
//

import Foundation

enum Day06 {
    static func run() {
        let input1 = readFile("day06.input")
        let lines = input1.lines
        let time = lines[0].components(separatedBy: " ").compactMap { Int($0) }
        let distance = lines[1].components(separatedBy: " ").compactMap { Int($0) }
        print("Time: ", time)
        print("Distance: ", distance)
        let time2 = Int(lines[0].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
        let distance2 = Int(lines[1].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0

        print("Part 1: ", day06Part1(time: time, distance: distance))
        print("Part 2: ", day06Part2(time: time2, distance: distance2))
    }
}


func countWinning(time: Int) -> [Int] {
    var distances = [Int]()
    for i in 1...(time-1) {
        let distance = i*(time-i)
        distances.append(distance)
    }
    return distances
}

func day06Part1(time: [Int], distance: [Int]) -> Int {
    var winningDistances = [Int]()
    for (i, t) in time.enumerated() {
        winningDistances.append(countWinning(time: t).filter { $0 > distance[i] }.count)
        
    }
    return winningDistances.reduce(1,*)
}

func day06Part2(time: Int, distance: Int) -> Int {
    var winningDistances = [Int]()
        winningDistances.append(countWinning(time: time).filter { $0 > distance }.count)
        
    return winningDistances.reduce(1,*)
}
