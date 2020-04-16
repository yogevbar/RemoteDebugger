//
//  Antelope+File.swift
//  Antelope
//
//  Created by Daniel Huri on 12/15/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

/** The source file descriptor */
struct File: Codable {
    
    /** The path of the file excluding the file name and extension */
    let path: String
    
    /** The name of the file excluding the extension */
    let name: String
    
    /** The extension of the file */
    let `extension`: String
    
    /** The name of the file including the extension */
    var sourceFile: String {
        return "\(name).\(`extension`)"
    }
    
    var pathComponents: [String] {
        return path.components(separatedBy: "/")
    }
    
    /** Initialize with a full path */
    init(file: StaticString) {
        let components = "\(file)".components(separatedBy: "/")
        self.path = components.dropLast().joined(separator: "/")
        
        let fileNameComponents = components.last!.components(separatedBy: ".")
        self.name = fileNameComponents[0]
        self.extension = fileNameComponents[1]
    }
    
    func contains(pathComponent: String) -> Bool {
        return pathComponents.contains(pathComponent)
    }
}

// MARK: - Equatable

extension File: Equatable {}

// MARK: - Printable

/** Printable reppresentations of a File */
extension File: Printable {
    var pretty: String {
        return """
            Location: \(path)
            Name: \(sourceFile)
        """
    }
    
    var json: String {
        return jsonString
    }
}

/** Formatted description of the file */
extension File: CustomStringConvertible {
    var description: String {
        return print(as: .pretty)
    }
}
