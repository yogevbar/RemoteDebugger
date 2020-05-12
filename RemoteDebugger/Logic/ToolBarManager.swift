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
    let leftViewIsEnabled = PassthroughSubject<Bool, Never>()
    let showRightView = PassthroughSubject<Bool, Never>()
    let rightViewIsEnabled = PassthroughSubject<Bool, Never>()
    let trashIsEnabled = PassthroughSubject<Bool, Never>()
    init() {
        
        rightViewIsEnabled.send(false)
        showRightView.send(false)
        showLeftView.send(false)
        leftViewIsEnabled.send(false)
        trashIsEnabled.send(false)
        
        Publishers.CombineLatest(showLeftView, leftViewIsEnabled)
        .map{ $0 && $1 }
        .sink { [weak self] show in
            self?.showMenu = show
        }
        .store(in: &cancelSet)
        
        Publishers.CombineLatest(showRightView, rightViewIsEnabled)
        .map { $0 && $1 }
        .sink { [weak self] show in
            self?.showDetails = show
        }
        .store(in: &cancelSet)
    }
}
