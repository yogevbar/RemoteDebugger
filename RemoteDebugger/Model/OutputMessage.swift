//
//  OutputMessage.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 28/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

enum OutputMessageType: String, Codable {
    case sendSessionsList
    case sendSession
}

struct OutputMessage: Codable {
    let type: OutputMessageType
    var sessionId: String?
}
