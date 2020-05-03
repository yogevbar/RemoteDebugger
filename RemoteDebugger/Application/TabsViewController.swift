//
//  TabsViewController.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 02/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine

class TabsViewController: NSViewController {

    @IBOutlet weak var tabView: LYTabView!
    
    private var cancelSet: Set<AnyCancellable> = []
    
    private let sessionManager      = SessionManager()
    private let toolBarManager      = ToolBarManager()
    private let oldSessionsManager  = OldSessionsManager()
    private var openTabs = [String: NSTabViewItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabView()
        bind()
    }
        
    private func setupTabView() {
        tabView.tabBarView.minTabHeight = 27
        tabView.tabBarView.minTabItemWidth = 120
        tabView.tabBarView.showAddNewTabButton = false
    }
    
    private func bind() {
        sessionManager.openSession.compactMap { $0 }
            .sink { [weak self] (openSession) in
                self?.addViewWithLabel("Current Session", sessionViewModel: openSession)
        }.store(in: &cancelSet)
        
        sessionManager.oldSessionsInfo.sink { [weak self] sessions in
            self?.oldSessionsManager.oldSessions = sessions
        }.store(in: &cancelSet)
        
        sessionManager.oldSessionDetails.sink { [weak self] session in
            guard let session = session else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.string(from: session.sessionDetails.sessionStartDate)
            self?.addViewWithLabel(date, sessionViewModel: session)
        }.store(in: &cancelSet)
    }
    
    func addViewWithLabel(_ label: String, sessionViewModel: SessionViewModel) {
        
        if let tab = openTabs[label] {
            tabView.selectTabViewItem(tab)
            return
        }
        
        let item = NSTabViewItem()
        item.label = label
        
        let content = ContentView(openSession: { sessionId in
            self.sessionManager.openOldSession(sessionId: sessionId)
        })
            .environmentObject(toolBarManager)
            .environmentObject(sessionViewModel)
            .environmentObject(oldSessionsManager)
        let contentView = NSHostingView(rootView: content)
        item.view = contentView
        tabView.addTabViewItem(item)
        tabView.selectTabViewItem(item)
    }
}
