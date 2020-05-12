//
//  NearbyScanner.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 06/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol DeviceLocatorDelegate: class {
    func didLocate(device: NearbyDevice)
}

class NearbyScanner: NSObject {
    
    struct Configuration {
        static let serviceType = "debugger"
    }
    
    weak var delegate: DeviceLocatorDelegate!
    
    var browser: MCNearbyServiceBrowser!
    
    var isBrowsing = false
    
    var peerID: MCPeerID { return NearbySession.instance.peerID }
    
    init(delegate: DeviceLocatorDelegate) {
        super.init()
        self.delegate = delegate
        self.browser = MCNearbyServiceBrowser(peer: self.peerID, serviceType: Configuration.serviceType)
        self.browser.delegate = self
    }
}

extension NearbyScanner {
    func stopLocating() {
        self.browser?.stopBrowsingForPeers()
        self.isBrowsing = false
    }
    
    func startLocating() {
        self.isBrowsing = true
        self.browser.startBrowsingForPeers()
    }
    
    func reinvite(device: NearbyDevice) {
        if device.state < .invited {
            device.invite(with: self.browser)
        }
    }
}

extension NearbyScanner: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("Found peer: \(peerID.displayName)")
        let device = NearbySession.instance.device(for: peerID) ?? NearbyDevice(peerID: peerID, info: info)
        delegate.didLocate(device: device)
        if device.state != .connected && device.state != .invited {
            device.state = .found
            device.stopSession()
        }
        device.invite(with: self.browser)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Lost peer: \(peerID.displayName)")
        if let device = NearbySession.instance.device(for: peerID) {
            device.disconnect()
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("Error when starting browsing: \(error)")
        self.isBrowsing = false
    }
}
