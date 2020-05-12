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

    private let session = NearbySession.instance
    
    //MARK: data sources
    @Published var availablePeers = [NearbyDevice]() {
        didSet {
            if status.value == .searching && availablePeers.count > 0 {
                status.send(.availablePeers)
            }
            objectWillChange.send()
        }
    }
    
    var connectedPeer: NearbyDevice? {
        didSet {
            if connectedPeer != nil {
                status.send(.connected)
            }
        }
    }
    
    enum PeerStatus {
        case searching
        case availablePeers
        case connected
        case disconnected
    }

    var status = CurrentValueSubject<PeerStatus, Never>(.searching)

    init() {
        initClousers()
    }
    
    func connectToPeer(peer: NearbyDevice) {
        session.disconnect()
        let message = Message(type: .bindCommand)
        peer.send(message: message)
        peer.state = .bounded
        connectedPeer = peer
        NotificationCenter.default.post(name: .peerConnecting, object: nil)
    }
    
    private func peerDisconnected() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .peerDisconnected, object: nil)
        }
    }
}

extension PeersManager {
    private func initClousers() {
        session.addDevicesUpdateHandlers { [weak self] devices in
            self?.availablePeers = devices
        }
        
        session.addDeviceUpdateHandler { [weak self] device in
            guard let status = self?.status.value else {
                return
            }
            
            if status == .connected && device.state != .bounded {
                self?.status.send(.disconnected)
            } else if status == .availablePeers && device.state == .bounded {
                self?.status.send(.connected)
            }
        }
    }
}

