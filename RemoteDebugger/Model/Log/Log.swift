//
//  Log.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

/** Contains all the already parsed and formatted log info */
public struct Log: Identifiable {
    
    /** The id of the log - can be used to identify the same logs in multiple destinations */
    public var id: String
    
    /** The raw message reported by the developer */
    var message: String
    
    /** The log level */
    var level: Level
    
    /** Tags to which the log is linked to, makes tracing and breadcrumbs easier */
    var tags: [Tag]
    
    /** Copy tags */
    var tagsList: [TagModel]
    
    /** The origin function in the stack trace */
    var function: Function
    
    /** The source file info from the stack trace */
    var file: File
    
    /** The line of the log inside the source file */
    var line: Int
    
    /** The thread / queue available info */
    var thread: String
    
    /** The timestamp since 1970, on which the info was logged */
    var timestamp: TimeInterval
    
    /** Any data that the developer wishes recorded as well */
    var developerData: String
    
    /** The type of the destination */
    var destinationType: DestinationOptionSet
    
    /** The date of the log */
    var date: Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    /** Initializer for logger */
    public init(id: String, message: String, level: Level, tags: [Tag],
                function: StaticString, file: StaticString, line: Int, thread: String,
                date: Date, developerData: String = "", destinationType: DestinationOptionSet = .console) {
        self.id = id
        self.message = message
        self.level = level
        self.function = Function(with: function)
        self.file = File(file: file)
        self.line = line
        self.thread = thread
        self.timestamp = date.timeIntervalSince1970
        self.tags = tags
        self.developerData = developerData
        self.destinationType = destinationType
        self.tagsList = tags.map { TagModel(tag: $0) }
    }
}

// MARK: - Hashable

extension Log: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Codable

extension Log: Codable {
    
    // Coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case level
        case tags
        case function
        case file
        case line
        case thread
        case timestamp
        case developerData
        case destinationType
    }
    
    // MARK: - Decodable
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        message = try container.decode(String.self, forKey: .message)
        level = try container.decode(Level.self, forKey: .level)
        function = try container.decode(Function.self, forKey: .function)
        file = try container.decode(File.self, forKey: .file)
        line = try container.decode(Int.self, forKey: .line)
        thread = try container.decode(String.self, forKey: .thread)
        timestamp = try container.decode(TimeInterval.self, forKey: .timestamp)
        tags = try container.decode([Tag].self, forKey: .tags)
        developerData = try container.decode(String.self, forKey: .developerData)
        destinationType = try container.decode(DestinationOptionSet.self, forKey: .destinationType)
        tagsList = tags.map { TagModel(tag: $0) }
    }
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(message, forKey: .message)
        try container.encode(level, forKey: .level)
        try container.encode(tags, forKey: .tags)
        try container.encode(function, forKey: .function)
        try container.encode(file, forKey: .file)
        try container.encode(line, forKey: .line)
        try container.encode(thread, forKey: .thread)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(developerData, forKey: .developerData)
        try container.encode(destinationType, forKey: .destinationType)
    }
}

// MARK: - Comparable

extension Log: Comparable {
    public static func == (lhs: Log, rhs: Log) -> Bool {
        return lhs.id == rhs.id
    }
    
    public static func < (lhs: Log, rhs: Log) -> Bool {
        return lhs.date.compare(rhs.date) == .orderedAscending
    }
}

// MARK: - Printable

extension Log: Printable {
    var pretty: String {
        let string =
        """
        Message: \(message)
        Developer Data: \(developerData)
        Tags: \(tags)
        File:\n\(file)
        Function:\n\(function)
        Line: \(line)
        Thread: \(thread)
        Time:\n\(dateDescription)
        """
        return prettyFormat(string: string)
    }
    
    var json: String {
        return jsonString
    }
}

// MARK: - Readable Format

// TODO: Decide about the most readable format
extension Log: CustomStringConvertible {
    
    public var description: String {
        return pretty
    }
    
    private var dateDescription: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let description = formatter.string(from: date).components(separatedBy: " ")
        return """
        \(description[0])
        \(description[1])
        """
    }
}
