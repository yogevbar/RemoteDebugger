//
//  Antelope+Tag.swift
//  Antelope
//
//  Created by Daniel Huri on 12/12/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

protocol AntelopeTagProtocol {
    var name: String { get }
//    var backgroundColor: UIColor { get }
}

/** Descriptor of a tag */
public struct Tag: AntelopeTagProtocol, Hashable {
    
    /** The name of the tag, plays as a unique identifier */
    let name: String
    
    /** The background color of the tag - consider moving in AntelopeInterface */
    let backgroundColorHex: Int
    
//    var backgroundColor: UIColor {
//        return UIColor(rgb: 0)
//    }
    
    public init(name: String, backgroundColorHex: Int) {
        self.name = name
        self.backgroundColorHex = backgroundColorHex
    }
    
    // MARK: Modularity
    
    public static let network = Tag(name: "network", backgroundColorHex: 0xD0281E)
    public static let infrastructure = Tag(name: "infra", backgroundColorHex: 0xF57800)
    public static let model = Tag(name: "model", backgroundColorHex: 0xFFA400)
    public static let view = Tag(name: "view", backgroundColorHex: 0xF3DEAF)
    
    // MARK: UI
    
    public static let constraints = Tag(name: "constraints", backgroundColorHex: 0x2F4960)
    
    // MARK: Cache
    
    public static let database = Tag(name: "database", backgroundColorHex: 0x2B2B2B)
    public static let cache = Tag(name: "cache", backgroundColorHex: 0xA652BB)
    
    // MARK: WIP/Development
    
    public static let todo = Tag(name: "todo", backgroundColorHex: 0x247083)
    public static let tbd = Tag(name: "tbd", backgroundColorHex: 0x0099E1)
    public static let fixme = Tag(name: "fixme", backgroundColorHex: 0x00D166)
    public static let rename = Tag(name: "rename", backgroundColorHex: 0x00A384)
    public static let refactor = Tag(name: "refactor", backgroundColorHex: 0xBCC3C7)
    
    // MARK: Process
    
    public static let success = Tag(name: "success", backgroundColorHex: 0x22613E)
    public static let failure = Tag(name: "failure", backgroundColorHex: 0x7A5ACC)
    public static let cancel = Tag(name: "cancel", backgroundColorHex: 0x653060)
}

// MARK: - Codable

extension Tag: Codable {}

// MARK: - Printable

extension Tag: Printable {
    var pretty: String {
        return """
            Name: \(name)
            Color: \(backgroundColorHex)
        """
    }
    
    var json: String {
        return jsonString
    }
}

// MARK: - Readable Description

extension Tag: CustomStringConvertible {
    public var description: String {
        return name
    }
}
