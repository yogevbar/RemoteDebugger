//
//  MessageFilter.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** Message based filter types */
enum MessageFilter: LogFilter {
    
    /** Message contains substring */
    case contains(substring: String, isCaseSensitive: Bool)
    
    /** Message begins with a given substring */
    case beginsWith(substring: String, isCaseSensitive: Bool)
    
    /** Message ends with a given substring */
    case endsWith(substring: String, isCaseSensitive: Bool)
    
    /** An empty message - trace only */
    case empty
    
    /** Not an empty message */
    case notEmpty
    
    /** Message length is shorter or equal to */
    case shorterOrEqualTo(maximumLength: UInt)
    
    /** Message length is longer or equal to */
    case longerOrEqualTo(minimumLength: UInt)
    
    /** Message length is equal to */
    case equalInLengthTo(length: UInt)
    
    // MARK: - Filter
    
    func filter(log: Log) -> Bool {
        
        let process = { (substring: String, isCaseSensitive: Bool) -> (String, String) in
            var message = log.message
            var substring = substring
            if !isCaseSensitive {
                message = message.lowercased()
                substring = substring.lowercased()
            }
            return (message, substring)
        }
        
        switch self {
        case .contains(substring: let substring, isCaseSensitive: let isCaseSensitive):
            let (message, substring) = process(substring, isCaseSensitive)
            return message.contains(substring)
        case .beginsWith(substring: let substring, isCaseSensitive: let isCaseSensitive):
            let (message, substring) = process(substring, isCaseSensitive)
            return message.hasPrefix(substring)
        case .endsWith(substring: let substring, isCaseSensitive: let isCaseSensitive):
            let (message, substring) = process(substring, isCaseSensitive)
            return message.hasSuffix(substring)
        case .empty:
            return log.message.isEmpty
        case .notEmpty:
            return !log.message.isEmpty
        case .shorterOrEqualTo(maximumLength: let length):
            return log.message.count <= length
        case .longerOrEqualTo(minimumLength: let length):
            return log.message.count >= length
        case .equalInLengthTo(length: let length):
            return log.message.count == length
        }
    }
}
