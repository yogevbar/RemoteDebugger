//
//  TabsViewModel.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 03/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

class TabsViewModel {
    
    var currentSession: SessionViewModel?
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearAllLogs(notification:)), name: .cleanLogs, object: nil)
    }
    
    @objc private func clearAllLogs(notification: Notification) {
        guard let currentSession = currentSession else { return }
        currentSession.clearAllLogs()
    }
}
