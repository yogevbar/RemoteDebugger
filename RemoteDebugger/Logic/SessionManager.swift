//
//  SessionManager.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 03/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import Combine

class SessionManager: ObservableObject {
    
    // MARK: Privates
    private let networking = NetworkServiceManager.shared
    
    // MARK: Subjects
    var openSession = CurrentValueSubject<SessionViewModel?, Never>(nil)
    var oldSessionsInfo = CurrentValueSubject<[SessionPresentableInfo], Never>([])
    var oldSessionDetails = CurrentValueSubject<SessionViewModel?, Never>(nil)
    
    init() {
        initClousers()
        networking.startScanForConnection()
    }
    
    private func createOpenSession(sessionInfo: SessionInfo?) {
        guard let sessionInfo = sessionInfo else { return }
        let session = SessionViewModel(sessionDetails: sessionInfo)
        guard let current = openSession.value else {
            openSession.send(session)
            return
        }
        current.addCachedLogs(logs: sessionInfo.logs)        
    }
    
    private func createOldSession(sessionInfo: SessionInfo?) {
        guard let sessionInfo = sessionInfo else { return }
        let session = SessionViewModel(sessionDetails: sessionInfo)
        oldSessionDetails.send(session)
    }
    
    private func messageRecived(message: Codable) {
        guard let message = message as? InputMessage else { return }
        switch message.type {
        case .log:
            openSession.value?.addLog(log: message.log)
        case .oldSessions:
            oldSessionsInfo.send(message.prevSessionsDetails ?? [])
        case .openSession:
            createOpenSession(sessionInfo: message.sessionInfo)
        case .archive:
            createOldSession(sessionInfo: message.sessionInfo)
        }
    }
    
    func openOldSession(sessionId: String) {
        let message = OutputMessage(type: .sendSession, sessionId: sessionId)
        networking.send(message: message)
    }
}

extension SessionManager {
    private func initClousers() {
        networking.messageRecived = { [weak self] (message: Codable) in
            self?.messageRecived(message: message)
        }
    }
}
