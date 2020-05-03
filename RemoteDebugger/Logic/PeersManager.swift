//
//  PeersViewModel.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class PeersManager: ObservableObject {
    //MARK: privates
    private let networking: NetworkServiceManager
    
    //MARK: data sources
    @Published var peers = [Peer]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        networking = NetworkServiceManager.shared
        initClousers()
        networking.startScanForConnection()
    }
    
    func connectToPeer(peer: Peer) {
        guard peer.status != .connected && peer.status != .connecting else { return }
    
        objectWillChange.send()
        NotificationCenter.default.post(name: .peerConnecting, object: nil)
        networking.connectToPeer(peerID: peer.peerID)
    }
    
    private func peerConnected(peer: Peer) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .peerConnected, object: peer)
            let message = OutputMessage(type: .sendSessionsList)
            self.networking.send(message: message)
        }
    }
    
    private func peerDisconnected() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .peerDisconnected, object: nil)
        }
    }
    
    private func deletePeer(displayName: String) {
        guard let peer = peers.first(where: { $0.displayName == displayName }) else {
            return
        }
        
        if peer.status == .connected {
            peerDisconnected()
        }
        
        peers.removeAll { $0.displayName == displayName }
    }
    
    private func peerStatusChanged(displayName: String, status: PeerStatus) {
        guard let peer = peers.first(where: { $0.displayName == displayName }) else {
            return
        }
        
        peer.status = status
        
        if status == .connected {
            peerConnected(peer: peer)
        }
        
        if status == .disconnected {
            peerDisconnected()
        }
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}

extension PeersManager {
    private func initClousers() {
        
        networking.availablePeers = { [weak self] peer in
            self?.peers.append(peer)
        }
        
        networking.unavailablePeer = { [weak self] displayName in
            self?.deletePeer(displayName: displayName)
        }
        
        networking.peerStatusChange = { [weak self] (displayName, status) in
            self?.peerStatusChanged(displayName: displayName, status: status)
        }
    }
}

