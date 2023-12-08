//
//  day08.swift
//  AoC2023
//
//  Created by Marcel Mravec on 04.12.2023.
//

import Foundation

enum Day08 {
    static func run() {
        let input1 = readFile("day08.test2")
        let lines = input1.lines
        let rightLeftInstructions = lines[0].map { String($0) }
        let map = lines.dropFirst().sorted()
        print("RL instructions are: \(rightLeftInstructions)")
        print("Map is: \n\(map)")
        var node: Node<String>
        var mapOfNodes: [Node<String>] = []
        for line in map {
            let value = String(line.prefix(3))
            let stringToParse = line.components(separatedBy: ",")
            let leftValue = String(stringToParse[0].suffix(3))
            let rightValue = String(stringToParse[1].prefix(4).dropFirst())
            node = Node(value: value, leftValue: leftValue, rightValue: rightValue)
            mapOfNodes.append(node)
        }
        
        for node in mapOfNodes {
            if let searchIndex = mapOfNodes.firstIndex(where: { $0.value == node.leftValue }) {
                node.left = mapOfNodes[searchIndex]
                print("Connected \(node.value) to \(mapOfNodes[searchIndex].value) on the left.")
            } else {
                print("'\(node.leftValue)' not found in the array")
            }

            if let searchIndex = mapOfNodes.firstIndex(where: { $0.value == node.rightValue }) {
                node.right = mapOfNodes[searchIndex]
                print("Connected \(node.value) to \(mapOfNodes[searchIndex].value) on the right.")
            } else {
                print("'\(node.rightValue)' not found in the array")
            }
        }

        print("Map of nodes has \(mapOfNodes.count) nodes.")
        
        print(day08Part1(rightLeftInstructions, mapOfNodes))
        print(day08Part2(rightLeftInstructions, mapOfNodes))
    }
}

func day08Part1(_ instructions: [String], _ map: [Node<String>]) -> Int {
    var steps = 0
    var currentNode: Node<String>? = map.first
    
    while let current = currentNode {
        print("Current Node: \(current.value)")

        switch instructions[steps % instructions.count] {
        case "R": currentNode = current.right
            print("Moving right to \(currentNode?.value ?? "nil")")
        case "L": currentNode = current.left
            print("Moving left to \(currentNode?.value ?? "nil")")
        default: break
        }
        
        if current.value == "ZZZ" {
            break
        }
        steps += 1
    }
    return steps
}

func day08Part2(_ instructions: [String], _ map: [Node<String>]) -> Int {
    
    return 2
}



