//
//  Filter.swift
//  Antelope
//
//  Created by Daniel Huri on 12/12/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

/** TODO: - Filters
 1. tag (one or multiple)
 2. content - errors.
 */

/** A protocol which all filters must comply with */
public protocol LogFilter {
    
    /**
     Make a filter operation on a log construct.
     - parameter log: A log data to apply filter to.
     */
    func filter(log: Log) -> Bool
}
