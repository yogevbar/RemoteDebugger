//
//  SessionInfo.swift
//  Antelope
//
//  Created by Daniel Huri on 1/13/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

// TODO: Consider protocol from which both the destination and session info adopt attributes. This is important for codable naming convension.

/** Contains data about a single session */
public struct SessionInfo: Codable {
    
    // MARK: - Properties
    
    /** Identifier of the session */
    let identifier: String
    
    /** App info */
    let appInfo: AppInfo
    
    /** Session start date */
    let sessionStartDate: Date
    
    /** The level of the session */
    let level: Level
    
    /** Logs */
    var logs: [Log]
    
    // MARK: - Setup
    
    public init(identifier: String, appInfo: AppInfo, sessionStartDate: Date, level: Level, logs: [Log] = []) {
        self.identifier = identifier
        self.appInfo = appInfo
        self.sessionStartDate = sessionStartDate
        self.level = level
        self.logs = logs
    }
}
