//
//  MCPeerID+Extensions.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 06/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import MultipeerConnectivity

extension MCPeerID {
    static var cachedLocalPeerID: MCPeerID?
    static var localPeerID: MCPeerID {
        if let id = self.cachedLocalPeerID { return id }
        
        let key = "local-peerID"
        if let data = UserDefaults.standard.data(forKey: key), let id = MCPeerID.from(data: data) {
            self.cachedLocalPeerID = id
            return id
        }
        
        let peerID = MCPeerID(displayName: Host.current().name ?? "Host")
        UserDefaults.standard.set(peerID.data, forKey: key)
        self.cachedLocalPeerID = peerID
        return peerID
    }
    
    var data: Data {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
        } catch {
            return Data()
        }
    }
    
    static func from(data: Data) -> MCPeerID? {
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: self, from: data)
        } catch {
            return nil
        }
    }
}

extension MCSessionState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .connected: return "*conected*"
        case .notConnected: return "*notConnected*"
        case .connecting: return "*connecting*"
        @unknown default: return "*unknown*"
        }
    }
}


extension Notification.Name {
    func post(with device: NearbyDevice) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: self, object: device)
        }
    }
}
