//
//  FileFilter.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** File name based filters */
enum FileFilter: LogFilter {
    
    /** File name begins with a given prefix string (excluding extension) */
    case beginsWith(prefix: String)
    
    /** File name ends with a given suffix string (excluding extension) */
    case endsWith(suffix: String)
    
    /** File name is equal to a given substring (excluding extension) */
    case equalTo(name: String)
    
    /** File name contains a given substring (excluding extension) */
    case contains(substring: String)
    
    /** Extension name is equal to a given string */
    case extensionEqualTo(extension: String)
    
    // MARK: - Filter
    
    func filter(log: Log) -> Bool {
        switch self {
        case .beginsWith(prefix: let prefix):
            return log.file.name.hasPrefix(prefix)
        case .equalTo(name: let name):
            return log.file.name == name
        case .endsWith(suffix: let suffix):
            return log.file.name.hasSuffix(suffix)
        case .contains(substring: let substring):
            return log.file.name.contains(substring)
        case .extensionEqualTo(extension: let extensionName):
            return log.file.extension == extensionName
        }
    }
}
