//
//  ToolBarManager.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 03/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import Combine


class ToolBarManager: ObservableObject {
    
    var cancelSet: Set<AnyCancellable> = []
    
    @Published var showMenu = true {
        didSet {
            NotificationCenter.default.post(name: .leftSidebarToggle, object: showMenu)
        }
    }
    @Published var showDetails = false
    
    let showLeftView = PassthroughSubject<Bool, Never>()
    let showRightView = PassthroughSubject<Bool, Never>()
    
    init() {
        showLeftView
        .sink { [weak self] show in
            self?.showMenu = show
        }
        .store(in: &cancelSet)
        
        showRightView
        .sink { [weak self] show in
            self?.showDetails = show
        }
        .store(in: &cancelSet)

//        NotificationCenter.default
//        .publisher(for: .rightSidebarToggle)
//        .compactMap { ($0.object as! Toggles) }
//        .map { !$0.toggle }
//        .sink { [weak self] collapse in
//            self?.showDetails = collapse
//        }
//        .store(in: &cancelSet)
//
//        NotificationCenter.default
//        .publisher(for: .leftSidebarToggle)
//        .compactMap { ($0.object as! Toggles) }
//        .map { !$0.toggle }
//        .sink { [weak self] collapse in
//            self?.showMenu = collapse
//        }
//        .store(in: &cancelSet)
    }
}
