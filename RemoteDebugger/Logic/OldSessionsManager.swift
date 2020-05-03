//
//  OldSessionsManager.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 03/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

class OldSessionsManager: ObservableObject {
    
    @Published var oldSessions = [SessionPresentableInfo]()
    @Published var openSessions = [SessionInfo]()
    
}
