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
        let result = day06Part1(time: time, distance: distance)
        print(result)
        print(day06Part2(time: time, distance: distance))
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

func day06Part2(time: [Int], distance: [Int]) -> Int {
    
    return 2
}
