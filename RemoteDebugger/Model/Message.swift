//
//  Message.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 16/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

enum MessageType: String, Codable {
    case log
    case archive
    case cached
    case oldSessions
}

struct Message: Codable {
    let type: MessageType
    let log: Log?
    let cached: [Log]?
}
