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
    static let cleanLogs = Notification.Name("cleanLogs")
    static let leftSidebarToggle = Notification.Name("leftSidebarToggle")
    static let rightSidebarToggle = Notification.Name("rightSidebarToggle")
    static let rightSidebarEnabled = Notification.Name("rightSidebarEnabled")    
    static let leftSidebarEnabled = Notification.Name("leftSidebarEnabled")
    static let peerDetected = Notification.Name("peerDetected")
    static let noPeersDetection = Notification.Name("noPeersDetection")
}
