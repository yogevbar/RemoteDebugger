//
//  NotificationCenter+Exteinsions.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let peerConnected = Notification.Name("peerConnected")
    static let peerDisconnected = Notification.Name("peerDisconnected")
    static let peerConnecting = Notification.Name("peerConnecting")
}
