//
//  NearbyDevice.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 06/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import MultipeerConnectivity


public protocol NearbyDeviceDelegate: class {
    func didReceive(message: Message, from: NearbyDevice)
    func didChangeState(from: NearbyDevice)
}

open class NearbyDevice: NSObject {
    public struct Notifications {
        public static let deviceChangedState = Notification.Name("device-state-changed")
        public static let deviceConnected = Notification.Name("device-connected")
        public static let deviceConnectedWithInfo = Notification.Name("device-connected-with-info")
        public static let deviceDisconnected = Notification.Name("device-disconnected")
        public static let deviceChangedInfo = Notification.Name("device-changed-info")
    }
    
    public static let localDevice = NearbyDevice(asLocalDevice: true)
    
    public enum State: Int, Comparable {
        
        case none
        case found
        case invited
        case connecting
        case connected
        case ready
        case bounded

        var description: String {
            switch self {
            case .none: return "None"
            case .found: return "Found"
            case .invited: return "Invited"
            case .connected: return "Connected"
            case .connecting: return "Connecting"
            case .ready: return "Ready"
            case .bounded: return "Bounded"
            }
        }
        
        public static func < (lhs: State, rhs: State) -> Bool { return lhs.rawValue < rhs.rawValue }

    }
    
    public var lastReceivedSessionState = MCSessionState.connected
    open var discoveryInfo: [String: String]?
    typealias DeviceDisconnected = (_ device: NearbyDevice) -> Void
    var deviceDisconnected: DeviceDisconnected?
    
    public var deviceInfo: [String: String]?
    public var displayName: String
    public weak var delegate: NearbyDeviceDelegate?
    public let peerID: MCPeerID
    public let isLocalDevice: Bool
    public var uniqueID: String!
    public var appInfo: AppInfo? = nil
    open var state: State = .none {
        didSet {
            if state == .bounded {
                NearbyDevice.Notifications.deviceConnected.post(with: self)                
            }
            if state == oldValue { return }
            print("\(displayName), \(oldValue.description) -> \(state.description)")
            delegate?.didChangeState(from: self)
            checkForRSVP(state == .invited)
        }
    }
    
    public var session: MCSession?
    public let invitationTimeout: TimeInterval = 30.0
    weak var rsvpCheckTimer: Timer?
    
    open override var description: String {        
        return self.displayName
    }

    public required init(asLocalDevice: Bool) {
        isLocalDevice = asLocalDevice
        uniqueID = Host.current().address ?? ""
        discoveryInfo = [Keys.name: Host.current().name ?? "", Keys.unique: uniqueID]
        peerID = MCPeerID.localPeerID
        displayName = Host.current().address ?? "Host"
        super.init()
    }
    
    public required init(peerID: MCPeerID, info: [String: String]?) {
        isLocalDevice = false
        self.peerID = peerID
        displayName = peerID.displayName
        discoveryInfo = info
        uniqueID = info?[Keys.unique] ?? ""
        super.init()
        startSession()
        
    }
    
    func disconnectFromPeers() {
        print("Disconnecting from peers")
    }

    func invite(with browser: MCNearbyServiceBrowser) {
        state = .invited
        startSession()
        browser.invitePeer(peerID, to: session!, withContext: nil, timeout: invitationTimeout)
    }
    
    func setReconnection(completion: @escaping DeviceDisconnected) {
        deviceDisconnected = completion
    }
    
    func session(didChange state: MCSessionState) {
        lastReceivedSessionState = state
        var newState = self.state
        let oldState = self.state
        
        switch state {
        case .connected:
            newState = .connected
        case .connecting:
            newState = .connecting
            self.startSession()
        case .notConnected:
            newState = .found
            disconnect()
            deviceDisconnected?(self)

        @unknown default: break
        }
        
        if newState == self.state {
            return
        }
        
        self.state = newState
        
        defer { Notifications.deviceChangedState.post(with: self) }
        
        if self.state < .connected, oldState == .bounded {
            Notifications.deviceDisconnected.post(with: self)
        }
    }
    
    open func disconnect() {
        state = .none
        Notifications.deviceDisconnected.post(with: self)
        stopSession()
    }
    
    func stopSession() {
        print("Stopping: \(session == nil ? "nothing" : "session")")
        session?.disconnect()
        session = nil
    }
    
    func startSession() {
        if session == nil {
            session = MCSession(peer: NearbyDevice.localDevice.peerID, securityIdentity: nil, encryptionPreference: .optional)
            session?.delegate = self
        }
    }
    
    func send(message: Message) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(message)
            try self.session?.send(data, toPeers: [self.peerID], with: .reliable)
            print("Message sent: \(message.type)")
        } catch {
            print("Error \(error) when sending to \(self.displayName)")
        }
    }
    
    func session(didReceive data: Data) {
        do {
            let decoder = JSONDecoder()
            let message = try decoder.decode(Message.self, from: data)
            print("Message received: \(message.type)")
            self.delegate?.didReceive(message: message, from: self)
        } catch {
            print("Failed to decode message")
        }
    }
        
    static func ==(lhs: NearbyDevice, rhs: NearbyDevice) -> Bool {
        return lhs.peerID == rhs.peerID
    }
}

extension NearbyDevice {
    struct Keys {
        static let name = "name"
        static let idiom = "idiom"
        static let unique = "unique"
    }

    func checkForRSVP(_ start: Bool) {
        if !start {
            rsvpCheckTimer?.invalidate()
            return
        }
        
        if rsvpCheckTimer != nil { return }
        DispatchQueue.main.async {
            self.rsvpCheckTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(NearbyDevice.checkRSVPStatus), userInfo: nil, repeats: true)
        }
    }
    
    @objc func checkRSVPStatus() {
        if session?.connectedPeers.contains(peerID) == true {
            self.state = .connected
        }
    }
}

extension NearbyDevice: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        self.session(didChange: state)
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        self.session(didReceive: data)
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
    
}
