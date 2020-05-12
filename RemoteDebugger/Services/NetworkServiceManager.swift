//
//  NetworkServiceManager.swift
//  NetworkTest
//
//  Created by Yogev Barber on 09/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import MultipeerConnectivity

//enum PeerStatus {
//    case connected
//    case connecting
//    case disconnected
//}
//
//class NetworkServiceManager: NSObject {
//    
//    struct Configuration {
//        static let serviceType = "debugger"
//    }
//    
//    //MARK: shared instance
//    static let shared = NetworkServiceManager()
//    
//    //MARK: private members
//    private let session: MCSession
//    private var peerID = MCPeerID(displayName: "iMac")
//    private var mcAdvertiserAssistant: MCAdvertiserAssistant!
//    private var browser: MCNearbyServiceBrowser?
//    private var connectedPeer: MCPeerID?
//    
//    private var availablePeersList = Set<Peer>()
//    
//    //MARK: typeAliases
//    typealias AvailablePeers = (_ peers: [Peer]) -> ()
//    typealias PeerStatusChange = (_ displayName: String, _ status: PeerStatus) -> ()
//    typealias MessageRecived = (_ message: Codable) -> ()
//    
//    //MARK: public clousers
//    private var availablePeers: AvailablePeers?
//    private var peerStatusChange: PeerStatusChange?
//    private var messageRecived: MessageRecived?
//    
//    private override init() {
//        self.session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
//        super.init()
//        session.delegate = self
//    }
//    
//    func startScanForConnection() {
//        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: Configuration.serviceType)
//        browser?.delegate = self
//        browser?.startBrowsingForPeers()
//    }
//    
//    func startConnection() {
//        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: Configuration.serviceType, discoveryInfo: nil, session: session)
//        mcAdvertiserAssistant.start()
//    }
//    
//    func connectToPeer(peerID: MCPeerID, info: [String: String]?) {
//        disconnect()
//        browser?.invitePeer(peerID, to: session, withContext: nil, timeout: 30)
//    }
//    
//    func disconnect() {
//        guard let peer = connectedPeer else { return }
//        session.cancelConnectPeer(peer)
//        connectedPeer = nil
//    }
//    
//    private func peerStatusChanged(peerID: MCPeerID, status: MCSessionState) {
//        var peerStatus: PeerStatus
//        switch status {
//        case .connected:
//            connectedPeer = peerID
//            peerStatus = .connected
//        case .connecting:
//            peerStatus = .connecting
//        case .notConnected:
//            peerStatus = .disconnected
//        default:
//            peerStatus = .disconnected
//        }
//        peerStatusChange?(peerID.displayName, peerStatus)
//    }
//    
//    private func decodeMessage(data: Data) {
//        let decoder = JSONDecoder()    
//        do {
//            let obj = try decoder.decode(InputMessage.self, from: data)
//            DispatchQueue.main.async {
//                self.messageRecived?(obj)
//            }
//        } catch {
//            print("decoding error: \(error.localizedDescription)")
//        }
//    }
//    
//    func send<T: Encodable>(message: T) {
//        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(message)
//            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
//        } catch {
//            print("send error: \(error.localizedDescription)")
//        }
//    }
//    
//    func availablePeers(completion: @escaping AvailablePeers) {
//        self.availablePeers = completion
//    }
//    
//    func peerStatusChange(completion: @escaping PeerStatusChange) {
//        self.peerStatusChange = completion
//    }
//    
//    func messageRecived(completion: @escaping MessageRecived) {
//        self.messageRecived = completion
//    }
//}
//
//extension NetworkServiceManager: MCSessionDelegate {
//    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        switch state {
//        case .connected:
//            print("connected \(peerID.displayName)")
//        case .connecting:
//            print("connecting \(peerID.displayName)")
//        case .notConnected:
//            print("notConnected \(peerID.displayName)")
//        @unknown default:
//            print("unknown connection \(peerID.displayName)")
//        }
//        
//        peerStatusChanged(peerID: peerID, status: state)
//    }
//    
//    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        decodeMessage(data: data)
//        
//    }
//    
//    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
//        //MARK: Ignore this method
//    }
//    
//    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
//        //MARK: Ignore this method
//    }
//    
//    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
//        
//    }
//}
//
//extension NetworkServiceManager: MCNearbyServiceBrowserDelegate {
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {        
//        let peer = Peer(peerID: peerID, info: info)
//        availablePeersList.insert(peer)
//        availablePeers?(Array(availablePeersList))
////        if let connectedPeer = connectedPeer, peer.displayName == connectedPeer.displayName {
////            connectToPeer(peerID: peerID)
////        }
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        guard let peer = availablePeersList.first(where: { $0.peerID == peerID }) else { return }
//        availablePeersList.remove(peer)
//        availablePeers?(Array(availablePeersList))
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        print(error.localizedDescription)
//    }
//}
