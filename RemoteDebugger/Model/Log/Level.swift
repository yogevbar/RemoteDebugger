//
//  Antelope+Level.swift
//  Antelope
//
//  Created by Daniel Huri on 12/12/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

/** The level of the log */
public enum Level: Int {
    
    /** A verbose level of log */
    case verbose = 0
    
    /** A debug level of log */
    case debug
    
    /** An info level of log */
    case info
    
    /** A warning level of log */
    case warning
    
    /** An error level of log */
    case error
}

// MARK: - CaseIterable

extension Level: CaseIterable {}

// MARK: - Codable

extension Level: Codable {}

// MARK: - Comparable

extension Level: Comparable {
    public static func < (lhs: Level, rhs: Level) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Name

extension Level {
    public var name: String {
        switch self {
        case .verbose:
            return "verbose"
        case .debug:
            return "debug"
        case .info:
            return "info"
        case .warning:
            return "warning"
        case .error:
            return "error"
        }
    }
}
