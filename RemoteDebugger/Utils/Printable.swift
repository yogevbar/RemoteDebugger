//
//  Printable.swift
//  Antelope
//
//  Created by Daniel Huri on 12/15/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

/** The format of the log print */
public enum PrintableFormat {
    
    /** Pretty */
    case pretty
    
    /** Costruct raw */
    case raw
    
    /** Json */
    case json
}

protocol Printable {
    var pretty: String { get }
    var raw: String { get }
    var json: String { get }
    func print(as format: PrintableFormat) -> String
}

extension Printable {
    func print(as format: PrintableFormat) -> String {
        switch format {
        case .pretty:
            return pretty
        case .raw:
            return raw
        case .json:
            return json
        }
    }
    
    var raw: String {
        return String(describing: self)
    }
    
    func prettyFormat(string: String) -> String {
        return """
        "|----------------------------"
        \(string)
        "----------------------------|"
        """
    }
}
