//
//  NearbySession.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 06/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public class NearbySession: NSObject {

    public static let instance = NearbySession()
    
    private var deviceLocator: NearbyScanner!
    private var isShuttingDown = false
    private var isActive = false

    public var peerID: MCPeerID { return NearbyDevice.localDevice.peerID }
    public var devices: [Int: NearbyDevice] = [:]
    public var connectedDevices: [NearbyDevice] {
        return devices.values.filter { $0.state >= .ready }
    }
    
    typealias RecivedMessage = (_ message: Message, _ from: NearbyDevice) -> Void
    private var recivedMessageHandlers = [RecivedMessage]()
    
    typealias DevicesUpdate = (_ devices: [NearbyDevice]) -> ()
    private var devicesUpdateHandlers = [DevicesUpdate]()
    
    typealias DeviceUpdate = (_ device: NearbyDevice) -> ()
    private var deviceUpdateHandler = [DeviceUpdate]()
    
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(willTerminate), name: NSApplication.willTerminateNotification, object: nil)
        Message.register()
    }
    
    @objc private func willTerminate() {
        shutdown()
    }
    
    open func sendToAll(message: Message) {
        print("Sending \(message.type) to all")
        for device in connectedDevices.filter({ $0.state == .bounded }) {
            device.send(message: message)
        }
    }
    
    open func disconnect() {
        connectedDevices.filter({ $0.state == .bounded }).forEach { device in
            device.disconnect()
        }
    }
}

extension NearbySession {
    public func startup() {
        if isActive { return }
        isActive = true
        isShuttingDown = false
        devices = [:]
        locateDevice()
    }
    
    public func shutdown() {
        print("Shutting Down: \(peerID.displayName)")
        if !isActive || isShuttingDown { return }
        isActive = false
        isShuttingDown = true
        deviceLocator?.stopLocating()
        deviceLocator = nil
        for device in devices.values {
            device.disconnectFromPeers()
            device.state = .none
        }
    }
    
    private func locateDevice() {
        if self.deviceLocator != nil { return }            //already locating
        
        self.deviceLocator = NearbyScanner(delegate: self)
        self.deviceLocator?.startLocating()
    }
    
    func addReciveMessageHandler(handler: @escaping RecivedMessage) {
        recivedMessageHandlers.append(handler)
    }
    
    func addDevicesUpdateHandlers(handler: @escaping DevicesUpdate) {
        devicesUpdateHandlers.append(handler)
    }
    
    func addDeviceUpdateHandler(handler: @escaping DeviceUpdate) {
        deviceUpdateHandler.append(handler)
    }
    
    private func executeMessageHandlers(message: Message, from: NearbyDevice) {
        DispatchQueue.main.async {
            self.recivedMessageHandlers.forEach { handler in
                handler(message, from)
            }
        }
    }
    
    private func executeDevicesUpdateHandlers() {
        DispatchQueue.main.async {
            self.devicesUpdateHandlers.forEach { handler in
                handler(self.connectedDevices)
            }
        }
    }
    
    private func executeDeviceUpdateHandler(device: NearbyDevice) {
        DispatchQueue.main.async {
            self.deviceUpdateHandler.forEach { handler in
                handler(device)
            }
        }
    }
}

extension NearbySession: DeviceLocatorDelegate {
    func didLocate(device: NearbyDevice) {
        devices[device.peerID.hashValue] = device
        device.delegate = self
        device.setReconnection { [weak self] device in
            self?.deviceLocator?.reinvite(device: device)
        }
    }
    
    func device(for peerID: MCPeerID) -> NearbyDevice? {
        if let device = devices[peerID.hashValue] {
            return device
        }
        
        return nil
    }
}

extension NearbySession: NearbyDeviceDelegate {
    public func didReceive(message: Message, from: NearbyDevice) {
        switch message.type {
        case .infoWithAppInfo:
            from.appInfo = message.payload as? AppInfo
            from.state = .ready
        default:
            executeMessageHandlers(message: message, from: from)
        }
    }
    
    public func didChangeState(from: NearbyDevice) {
        guard from.state != .bounded else {
            return
        }
        DispatchQueue.main.async {
            self.executeDevicesUpdateHandlers()
            self.executeDeviceUpdateHandler(device: from)
        }
    }
}
