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
    private let networking = NearbySession.instance
    
    // MARK: Subjects
    var openSession = CurrentValueSubject<SessionViewModel?, Never>(nil)
    var oldSessionsInfo = CurrentValueSubject<[SessionPresentableInfo], Never>([])
    var oldSessionDetails = CurrentValueSubject<SessionViewModel?, Never>(nil)
    
    init() {
        initClousers()
    }
    
    private func createOpenSession(sessionInfo: SessionInfo?) {
        guard let sessionInfo = sessionInfo else { return }
        let session = SessionViewModel(sessionDetails: sessionInfo)
        guard let current = openSession.value, current.sessionDetails.identifier == sessionInfo.identifier else {
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
    
    private func messageRecived(message: Message) {
        switch message.type {
        case .logWithLogInfo:
            openSession.value?.addLog(log: message.payload as? Log)
        case .archiveSessionsWithPrevSessionsDetails:
            updateArchivedSessionsInfo(archivedSessions: message.payload as! [SessionPresentableInfo])
        case .archiveSessionWithSession:
            createOldSession(sessionInfo: message.payload as? SessionInfo)
        case .startSessionWithSession:
            createOpenSession(sessionInfo: message.payload as? SessionInfo)
        default:
            break
        }
    }
    
    private func updateArchivedSessionsInfo(archivedSessions: [SessionPresentableInfo]) {
        let archive = archivedSessions.filter { $0.date != openSession.value?.sessionDetails.sessionStartDate }
        oldSessionsInfo.send(archive)
    }
    
    func openOldSession(sessionId: String) {
        let message = Message(type: .archiveSessionWithIdCommand, payload: sessionId)
        networking.sendToAll(message: message)
    }
}

extension SessionManager {
    private func initClousers() {
        networking.addReciveMessageHandler { (message, device) in
            self.messageRecived(message: message)
        }
    }
}
