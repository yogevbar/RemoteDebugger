//
//  Array+Log.swift
//  AntelopeDemo
//
//  Created by Daniel Huri on 2/7/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
    /** Insert a new element to an array of elements (optimized for an array of logs) */
    mutating func insertSorted(_ element: Element) -> Int {
        let reversedSelf = reversed()
        let maxCount = Swift.max(reversedSelf.count, 1)
        let first = zip(0...maxCount, reversedSelf).first { (index, current) -> Bool in
            return element > current
        }
        let eventualIndex: Int
        if let first = first {
            eventualIndex = count - first.0
        } else {
            eventualIndex = 0
        }
        insert(element, at: eventualIndex)
        return eventualIndex
    }
}
