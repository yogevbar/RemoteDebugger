//
//  Function.swift
//  Antelope
//
//  Created by Daniel Huri on 1/18/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

/** Descriptor of #function */
struct Function: Codable {
    
    /** The stripped name of the function (with the exception of parameter names and return value) */
    let name: String
    
    /** The names of the parameters */
    let parameters: [String]
    
    init(with function: StaticString) {
        let components = "\(function)".components(separatedBy: "(")
        name = components[0]
        if components.count > 1 {
            var parameters = components[1].components(separatedBy: ":")
            parameters.removeLast()
            self.parameters = parameters
        } else {
            parameters = []
        }
    }
}

// MARK: - Equatable

extension Function: Equatable {}

/** Printable reppresentations of a Function */
extension Function: Printable {
    var pretty: String {
        let parameters = self.parameters.joined(separator: ", ")
        return """
        Name: \(name)
        Parameters: \(parameters)
        """
    }
    
    var json: String {
        return jsonString
    }
}

/** Formatted description of the function */
extension Function: CustomStringConvertible {
    var description: String {
        return print(as: .pretty)
    }
}
