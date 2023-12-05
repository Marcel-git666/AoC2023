//
//  day05.swift
//  AoC2023
//
//  Created by Marcel Mravec on 04.12.2023.
//

import Foundation

enum Day05 {
    static func run() {
        let input = readFile("day05.input")
        let lines = input.lines
        
        // Parse seeds
        let seeds = lines[0].components(separatedBy: " ").compactMap { Int($0) }
        
        // Parse the rest into the desired structures
        var almanach: [Page] = []
        
        var currentIndex = 1
        var pageNumber = 1
        var ranges: [AlmanachRange] = []
        
        while currentIndex < lines.count {
            let line = lines[currentIndex]
            
            if line.hasSuffix("map:") {
                if pageNumber > 1 {
                    // Skip the first page since it's actually the seeds
                    let page = Page(ranges: ranges)
                    almanach.append(page)
                    
                    // Print page information
                    print("Page \(pageNumber - 1):")
                    for almanachRange in ranges {
                        print("  \(almanachRange.destinationRangeStart) \(almanachRange.sourceRangeStart) \(almanachRange.rangeLength)")
                    }
                    print()
                    
                    ranges = []
                }
                
                pageNumber += 1
                currentIndex += 1
                continue
            }
            
            let values = line.components(separatedBy: " ").compactMap { Int($0) }
            
            // Check if values array has the expected number of elements
            guard values.count == 3 else {
                print("Error on line \(currentIndex + 1): Unexpected number of elements in values array.")
                print("Line content: \(line)")
                currentIndex += 1
                continue
            }
            
            let range = AlmanachRange(
                destinationRangeStart: values[0],
                sourceRangeStart: values[1],
                rangeLength: values[2]
            )
            ranges.append(range)
            currentIndex += 1
        }
        
        // Handle the last page
        let page = Page(ranges: ranges)
        almanach.append(page)
        
        // Print the last page information
        print("Page \(pageNumber - 1):")
        for almanachRange in ranges {
            print("  \(almanachRange.destinationRangeStart) \(almanachRange.sourceRangeStart) \(almanachRange.rangeLength)")
        }
        print()
        
        // Now you have the parsed data in the 'seeds' array and 'almanach' array
        print("Seeds: \(seeds)")
        
        let result = day05Part1(seeds: seeds, almanach: almanach)
        print(result)
        print(day05Part2(input))
    }
}


func transform(source: Int, page: Page) -> Int {
    var destinationValue = 0
    var isDestinationModified = false
    for r in page.ranges {
        if (source >= r.sourceRangeStart)  && (source <= (r.sourceRangeStart+r.rangeLength)) {
            destinationValue += r.destinationRangeStart + source - r.sourceRangeStart
            isDestinationModified = true
        }
    }
    if !isDestinationModified {
        destinationValue = source
    }
    return destinationValue
}

func day05Part1(seeds: [Int], almanach: [Page]) -> Int {
    var distance = [Int]()
    for seed in seeds {
        var source = seed
        var destination = 0
        for page in almanach {
            destination = transform(source: source, page: page)
            source = destination
        }
        distance.append(destination)
    }
    return distance.min() ?? 666
}

func day05Part2(_ input: String) -> Int {
    
    return 2
}

struct Page {
    var ranges: [AlmanachRange]
}

struct AlmanachRange {
    var destinationRangeStart: Int
    var sourceRangeStart: Int
    var rangeLength: Int
}
