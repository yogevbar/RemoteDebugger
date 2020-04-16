//
//  FilterContainer.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** A container for log filters */
public struct LogFilterContainer {
    
    // MARK: - Properties
    
    public static var empty: LogFilterContainer {
        return LogFilterContainer()
    }
    
    /** Required filters - include any log that correspods to those filters */
    private(set) public var required: [LogFilter] = []
    
    /** Excluded filters - exclude any log that corresponds to those filters */
    private(set) public var excluded: [LogFilter] = []
    
    /** Add a required filter */
    public mutating func add(required filters: LogFilter...) {
        add(required: filters)
    }
    
    /** Add a required filter */
    public mutating func add(required filters: [LogFilter]) {
        required += filters
    }
    
    /** Add an excluded filter */
    public mutating func add(excluded filters: LogFilter...) {
        add(excluded: filters)
    }
    
    /** Add an excluded filter */
    public mutating func add(excluded filters: [LogFilter]) {
        excluded += filters
    }

    /** Apply required and excluded filters */
    public func apply(to log: Log) -> Bool {
        // Apply required filters to log - Log must pass each required filter.
        if (required.contains { !$0.filter(log: log) }) {
            return false
        }
        // Apply excluded filters to log, must not pass in for `true` to be returned
        return !excluded.contains { $0.filter(log: log) }
    }
}
