//
//  FunctionFilter.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** Function based filter types */
enum FunctionFilter: LogFilter {

    /** Function name begins with a given prefix string (excludes extenal parameter names) */
    case beginsWith(prefix: String)
    
    /** Function name ends with a given suffix string (excludes extenal parameter names) */
    case endsWith(suffix: String)
    
    /** Function name is equal to a given name (excludes extenal parameter names) */
    case equalsTo(name: String)
    
    /** Function name contains a given substring (excludes extenal parameter names) */
    case contains(substring: String)
    
    /** Function receives an parameter with a given external parameter name  */
    case receivesParameter(name: String)
    
    // MARK: - Filter

    func filter(log: Log) -> Bool {
        switch self {
        case .beginsWith(prefix: let prefix):
            return log.function.name.hasPrefix(prefix)
        case .endsWith(suffix: let suffix):
            return log.function.name.hasSuffix(suffix)
        case .equalsTo(name: let name):
            return log.function.name == name
        case .contains(substring: let substring):
            return log.function.name.contains(substring)
        case .receivesParameter(name: let name):
            return log.function.parameters.contains(name)
        }
    }
}
