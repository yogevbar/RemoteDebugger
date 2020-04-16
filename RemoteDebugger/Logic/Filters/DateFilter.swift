//
//  TimestampFilter.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** File path based filter types */
enum DateFilter: LogFilter {
    
    // MARK: - Date
    
    /** Log date is equal to a given date */
    case equalToDate(date: Date)
    
    /** Log date is after a given date */
    case afterDate(date: Date)
    
    /** Log date is at the exect time or after a given date */
    case atOrAfterDate(date: Date)
    
    /** Log date is before a given date */
    case beforeDate(date: Date)
    
    /** Log date is at the exect time or before a given date */
    case atOrBeforeDate(date: Date)
    
    /** Log date is within a given time range */
    case withinDateRange(lowerBound: Date, upperBound: Date)
    
    // MARK: - Timestamp
    
    /** Log timestamp is equal to a given timestamp */
    case equalToTimestamp(timestamp: TimeInterval)
    
    /** Log timestamp is after a given timestamp */
    case afterTimestamp(timestamp: TimeInterval)
    
    /** Log timestamp is at the exect time or after a given timestamp */
    case atOrAfterTimestamp(timestamp: TimeInterval)
    
    /** Log timestamp is before a given timestamp */
    case beforeTimestamp(timestamp: TimeInterval)

    /** Log timestamp is at the exect time or before a given timestamp */
    case atOrBeforeTimestamp(timestamp: TimeInterval)
    
    /** Log timestamp is within a given time range */
    case withinTimestampRange(lowerBound: TimeInterval, upperBound: TimeInterval)

    // MARK: - Time Consecutive
    
    // MARK: - Filter
    
    func filter(log: Log) -> Bool {
        switch self {
        case .equalToDate(date: let date):
            return DateFilter.equalToTimestamp(timestamp: date.timeIntervalSince1970).filter(log: log)
        case .afterDate(date: let date):
            return DateFilter.afterTimestamp(timestamp: date.timeIntervalSince1970).filter(log: log)
        case .atOrAfterDate(date: let date):
            return DateFilter.atOrAfterTimestamp(timestamp: date.timeIntervalSince1970).filter(log: log)
        case .beforeDate(date: let date):
            return DateFilter.beforeTimestamp(timestamp: date.timeIntervalSince1970).filter(log: log)
        case .atOrBeforeDate(date: let date):
            return DateFilter.atOrBeforeTimestamp(timestamp: date.timeIntervalSince1970).filter(log: log)
        case .withinDateRange(lowerBound: let lowerBound, upperBound: let uppperBound):
            return DateFilter.withinTimestampRange(lowerBound: lowerBound.timeIntervalSince1970, upperBound: uppperBound.timeIntervalSince1970).filter(log: log)
        case .equalToTimestamp(timestamp: let timestamp):
            return log.timestamp == timestamp
        case .afterTimestamp(timestamp: let timestamp):
            return log.timestamp > timestamp
        case .atOrAfterTimestamp(timestamp: let timestamp):
            return log.timestamp >= timestamp
        case .beforeTimestamp(timestamp: let timestamp):
            return log.timestamp < timestamp
        case .atOrBeforeTimestamp(timestamp: let timestamp):
            return log.timestamp <= timestamp
        case .withinTimestampRange(lowerBound: let lowerBound, upperBound: let uppperBound):
            return log.timestamp >= lowerBound && log.timestamp <= uppperBound
        }
    }
}
