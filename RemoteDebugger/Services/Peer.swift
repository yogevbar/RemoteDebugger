//
//  Peer.swift
//  NetworkTest
//
//  Created by Yogev Barber on 09/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Peer: Identifiable {
    
    let peerID: MCPeerID
    let displayName: String
    let id: String = UUID.random
    let info: [String: String]?
    var appIcon: NSImage?
    var status: PeerStatus = .disconnected
    
    init(displayName: String) {
        self.peerID = MCPeerID(displayName: displayName)
        self.displayName = displayName
        self.info = nil
    }
    
    init(peerID: MCPeerID, info: [String: String]?) {
        self.peerID = peerID
        self.displayName = peerID.displayName
        self.info = info        
        if let info = info {
            assambleAppIcon(info: info)
        }
    }
}


extension Peer {
    func assambleAppIcon(info: [String: String]) {
        
        var stringArray = Array(repeating: "", count: info.count)
        
        for (key, value) in info {
            if key.contains("icon_") {
                let index = Int(key.replacingOccurrences(of: "icon_", with: ""))!
                stringArray[index] = value
            }
        }

        let base64 = stringArray.joined()
        guard let decodedData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            return
        }
        
        appIcon = NSImage(data: decodedData)
        
    }
}
