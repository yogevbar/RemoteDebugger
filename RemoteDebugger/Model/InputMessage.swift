//
//  Message.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 16/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

enum InputMessageType: String, Codable {
    case log
    case archive
    case oldSessions
    case openSession
}

struct InputMessage: Codable {
    let type: InputMessageType
    var log: Log? = nil
    var cached: [Log]? = nil
    var prevSessionsDetails: [SessionPresentableInfo]? = nil
    var sessionInfo: SessionInfo? = nil
}
