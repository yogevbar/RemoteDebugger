//
//  LevelFilter.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** Level based filter types where verbose < debug < info < warning < error */
public enum LevelFilter: LogFilter {
    
    /** Level is higher than or equal to a given level */
    case higherThanOrEqualTo(level: Level)
    
    /** Level is higher than a given level */
    case higherThan(level: Level)
    
    /** Level is lower than or equal to a given level */
    case lowerThanOrEqualTo(level: Level)
    
    /** Level is lower than a given level */
    case lowerThan(level: Level)
    
    /** Level is equal to a given level */
    case equalTo(level: Level)
    
    // MARK: - Filter
    
    public func filter(log: Log) -> Bool {
        switch self {
        case .higherThan(level: let level):
            return log.level > level
        case .higherThanOrEqualTo(level: let level):
            return log.level >= level
        case .lowerThanOrEqualTo(level: let level):
            return log.level <= level
        case .lowerThan(level: let level):
            return log.level < level
        case .equalTo(level: let level):
            return log.level == level
        }
    }
}
