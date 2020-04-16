//
//  PathFilter.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** File path based filter types */
enum PathFilter: LogFilter {
    
    /** Path begins with a given string (excluding `file.extension`) */
    case beginsWith(prefix: String)
    
    /** Path ends with a given string (excluding `file.extension`) */
    case endsWith(suffix: String)
    
    /** Path is equal to a given string (excluding `file.extension`) */
    case equalTo(path: String)
    
    /** Contains a path component with a given name (excluding `file.extension`) */
    case containsComponent(componentName: String)
    
    // MARK: - Filter

    func filter(log: Log) -> Bool {
        switch self {
        case .beginsWith(prefix: let prefix):
            return log.file.path.hasPrefix(prefix)
        case .endsWith(suffix: let suffix):
            return log.file.path.hasSuffix(suffix)
        case .equalTo(path: let path):
            return log.file.path == path
        case .containsComponent(componentName: let name):
            return log.file.pathComponents.contains(name)
        }
    }
}
