//
//  day02.swift
//  AoC2023
//
//  Created by Marcel Mravec on 01.12.2023.
//

import Foundation

enum Day02 {
    static func run() {
        let input1 = readFile("day02.input")
        
        let result = day02Part1(input1)
        print(result)
        print(day02Part2(input1))
    }
}

func day02Part1(_ input: String) -> Int {
    var bagOfGames = [Bag]()
    let lines = input.lines
    print(lines)
    for line in lines {
        
        let parts = line.components(separatedBy: ":")
        let number = parts[0].compactMap { Int(String($0)) }.map {String($0)}.joined()
        var bag = Bag(id: Int(number) ?? 0, red: 0, green: 0, blue: 0)
        
        let games = parts[1].components(separatedBy: ";")
        for game in games {
            let cubes = game.components(separatedBy: ",")
            print("Cubes are: \(cubes)")
            for cube in cubes {
                print("Cube is \(cube)")
                if let numberOfCubes = Int(cube.compactMap({ Int(String($0)) }).map {String($0)}.joined()) {
                    print("Number of cubes is \(numberOfCubes)")
                    if cube.contains("red") {
                        if bag.red < numberOfCubes { bag.red = numberOfCubes }
                    } else if cube.contains("blue") {
                        if bag.blue < numberOfCubes { bag.blue = numberOfCubes }
                    } else if cube.contains("green") {
                        if bag.green < numberOfCubes { bag.green = numberOfCubes }
                    }
                }
            }
        }
        bagOfGames.append(bag)
    }
    var sumOfPossibleGames = 0
    for bagOfGame in bagOfGames {
        print("ID \(bagOfGame.id) is valid gane? \(bagOfGame.possible)")
        if bagOfGame.possible {
            sumOfPossibleGames += bagOfGame.id
        }
    }
    return sumOfPossibleGames
}

func day02Part2(_ input: String) -> Int {
    var bagOfGames = [Bag]()
    let lines = input.lines
    print(lines)
    for line in lines {
        
        let parts = line.components(separatedBy: ":")
        let number = parts[0].compactMap { Int(String($0)) }.map {String($0)}.joined()
        var bag = Bag(id: Int(number) ?? 0, red: 0, green: 0, blue: 0)
        
        let games = parts[1].components(separatedBy: ";")
        for game in games {
            let cubes = game.components(separatedBy: ",")
            print("Cubes are: \(cubes)")
            for cube in cubes {
                print("Cube is \(cube)")
                if let numberOfCubes = Int(cube.compactMap({ Int(String($0)) }).map {String($0)}.joined()) {
                    print("Number of cubes is \(numberOfCubes)")
                    if cube.contains("red") {
                        if bag.red < numberOfCubes { bag.red = numberOfCubes }
                    } else if cube.contains("blue") {
                        if bag.blue < numberOfCubes { bag.blue = numberOfCubes }
                    } else if cube.contains("green") {
                        if bag.green < numberOfCubes { bag.green = numberOfCubes }
                    }
                }
            }
        }
        bagOfGames.append(bag)
    }
    var sumOfPossibleGames = 0
    for bagOfGame in bagOfGames {
        print("Red \(bagOfGame.red) blue: \(bagOfGame.blue) green: \(bagOfGame.green)")
        sumOfPossibleGames += bagOfGame.red * bagOfGame.blue * bagOfGame.green
    }
    return sumOfPossibleGames
}

struct Bag {
    var id: Int
    var red: Int
    var green: Int
    var blue: Int
    var possible: Bool {
       red < 13 && green < 14 && blue < 15
    }
}
