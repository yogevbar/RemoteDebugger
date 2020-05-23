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
    private var dataSource = [String: SessionViewModel]()
    
    enum SessionType {
        case current
        case prevSession(date: Date)
        case unknown
        
        func description() -> String {
            switch self {
            case .current:
                return "Current Session"
            case .prevSession(let date):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                return formatter.string(from: date)
            case .unknown:
                return "Unknown Session"
            }
        }
    }
    
    private let sessionManager      = SessionManager()
    private let oldSessionsManager  = OldSessionsManager()
    private var openTabs = [String: NSTabViewItem]()
    var toolBarManager: ToolBarManager?
    var currentSessionTab: SessionViewModel?
    
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
                self?.startNewSession(sessionViewModel: openSession)
        }.store(in: &cancelSet)
        
        sessionManager.oldSessionsInfo.sink { [weak self] sessions in
            self?.oldSessionsManager.oldSessions = sessions
        }.store(in: &cancelSet)
        
        sessionManager.oldSessionDetails.sink { [weak self] session in
            self?.openOldSession(sessionViewModel: session)
        }.store(in: &cancelSet)
    }
    
    private func startNewSession(sessionViewModel: SessionViewModel) {
        guard let openSession = currentSessionTab else {
            currentSessionTab = sessionViewModel
            addViewWithLabel(SessionType.current.description(), sessionViewModel: sessionViewModel)
            return
        }
        
        if sessionViewModel.sessionDetails.identifier != openSession.sessionDetails.identifier {
            if let currentTab = searchForOpenTab(tabTitle: SessionType.current.description()) {
                currentTab.label = SessionType.prevSession(date: openSession.sessionDetails.sessionStartDate).description()
                addViewWithLabel(SessionType.current.description(), sessionViewModel: sessionViewModel)
            }
        }        
    }
    
    private func openOldSession(sessionViewModel: SessionViewModel?) {
        guard let session = sessionViewModel else { return }
        
        if let openTab = searchForOpenTab(tabTitle: SessionType.prevSession(date: session.sessionDetails.sessionStartDate).description()) {
            tabView.selectTabViewItem(openTab)
            return
        }
        
        addViewWithLabel(SessionType.prevSession(date: session.sessionDetails.sessionStartDate).description(), sessionViewModel: session)
    }
    
    private func searchForOpenTab(tabTitle: String) -> NSTabViewItem? {
        return tabView.tabViewItems.first { $0.label == tabTitle }
    }
    
    func addViewWithLabel(_ label: String, sessionViewModel: SessionViewModel) {
        
        defer {
            resignFirstResponder()
        }
        
        if let tab = openTabs[label] {
            tabView.selectTabViewItem(tab)
            return
        }
        
        let item = NSTabViewItem()
        item.label = label
        
        let content = ContentView(openSession: { sessionId in
            self.sessionManager.openOldSession(sessionId: sessionId)
        })
            .environmentObject(toolBarManager!)
            .environmentObject(sessionViewModel)
            .environmentObject(oldSessionsManager)
        let contentView = NSHostingView(rootView: content)
        item.view = contentView
        tabView.addTabViewItem(item)
        tabView.selectTabViewItem(item)
        dataSource[label] = sessionViewModel
    }
    
    func clearLogsFromTabs() {
        guard let item = tabView.selectedTabViewItem, let vm = dataSource[item.label] else { return }
        vm.clearAllLogs()
    }
    
    private func nextTab() {
        if let currentItem = tabView.currentItem, currentItem == tabView.tabViewItems.last {
            tabView.selectFirstTabViewItem(nil)
        } else {
            tabView.selectNextTabViewItem(nil)
        }
        
    }
    
    private func prevTab() {
        if let currentItem = tabView.currentItem, currentItem == tabView.tabViewItems.first {
            tabView.selectLastTabViewItem(nil)
        } else {
            tabView.selectPreviousTabViewItem(nil)
        }
    }
    
    private func closeCurrentTab() {
        guard let current = tabView.currentItem else { return }
        tabView.removeTabViewItem(current)
    }
    
    override func keyDown(with event: NSEvent) {
        if event.modifierFlags.contains([.shift, .command]) {
            if returnChar(theEvent: event) == "]" {
                nextTab()
            }
            
            if returnChar(theEvent: event) == "[" {
                prevTab()
            }
        } else {
            super.keyDown(with: event)
        }
    }
    
    private func returnChar(theEvent: NSEvent!) -> Character?{
        let s: String = theEvent.characters!
        let mod = theEvent.modifierFlags
        print(mod)
        for char in s {
            return char}
        return nil
    }
}
