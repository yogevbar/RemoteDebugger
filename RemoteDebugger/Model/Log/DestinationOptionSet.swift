//
//  DestinationReadable.swift
//  AntelopeDemo
//
//  Created by Daniel Huri on 2/7/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** Possible types of destinations */
public struct DestinationOptionSet: OptionSet, Codable {
    
    // MARK: - Properties
    
    public let rawValue: Int
    
    /** Console */
    
    /** File */
    public static let console = DestinationOptionSet(rawValue: 1 << 0)
    public static let file = DestinationOptionSet(rawValue: 1 << 1)
    
    /** All types */
    public static var all: DestinationOptionSet {
        return [console, file]
    }
    
    // MARK: - Setup
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
