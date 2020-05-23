//
//  MainWindow.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine

class MainWindow: NSWindowController {
    
    @IBOutlet weak var openButton: ProgressButton!
    @IBOutlet weak var rightSidebarToggle: NSButton!
    @IBOutlet weak var leftSidebarToggle: NSButton!
    @IBOutlet weak var clearContent: NSButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.minSize = NSSize(width: 1200, height: 800 )
        rightSidebarToggle.isEnabled = false
        leftSidebarToggle.isEnabled = false
        clearContent.isEnabled = false
        (contentViewController as! TabsViewController).toolBarManager = toolBarManager
        window?.toolbar?.showsBaselineSeparator = false
        bind()
        NearbySession.instance.startup()
    }
    
    private var popOver: NSPopover?
    private var toolBarManager = ToolBarManager()
    private var peersManager = PeersManager()
    private var cancelSet: Set<AnyCancellable> = []
    private var isSearchingForPeers = false

    private func bind() {
        toolBarManager.showLeftView
            .sink { [weak self] show in
                self?.leftSidebarToggle.state = show ? .on : .off
            }
            .store(in: &cancelSet)
        
        toolBarManager.showRightView
            .sink { [weak self] show in
                self?.rightSidebarToggle.state = show ? .on : .off
            }
            .store(in: &cancelSet)
        
        toolBarManager.rightViewIsEnabled
        .sink { [weak self] isEnabled in
            self?.rightSidebarToggle.isEnabled = isEnabled
            self?.toolBarManager.showRightView.send(isEnabled)
        }
        .store(in: &cancelSet)
        
        toolBarManager.leftViewIsEnabled
            .sink { [weak self] isEnabled in
                self?.leftSidebarToggle.isEnabled = isEnabled
                self?.toolBarManager.showLeftView.send(isEnabled)
        }
        .store(in: &cancelSet)
        
        toolBarManager.trashIsEnabled
        .sink { [weak self] isEnabled in
            self?.clearContent.isEnabled = isEnabled
        }
        .store(in: &cancelSet)
        
        peersManager.status.sink { [weak self] status in
            self?.hadnleStatus(state: status)
        }
        .store(in: &cancelSet)
    }
    
    private func hadnleStatus(state: PeersManager.PeerStatus) {
        switch state {
        case .searching:
            searchingForPeers()
            toolBarManager.leftViewIsEnabled.send(false)
            toolBarManager.trashIsEnabled.send(false)
        case .availablePeers:
            availablePeers()
            toolBarManager.trashIsEnabled.send(false)
        case .connected:
            toolBarManager.leftViewIsEnabled.send(true)
            toolBarManager.trashIsEnabled.send(true)
            peerConnected()
        case .disconnected:
            peerDisconnected()
        }
    }
    
    private func searchingForPeers() {
        isSearchingForPeers = true
        openButton.isEnabled = false
        openButton.title = "Searching..."
        openButton.alignment = .center
        startLoadingAnimation()
    }
    
    private func availablePeers() {
        isSearchingForPeers = false
        openButton.isEnabled = true
        openButton.title = "Click here to choose an app"
        openButton.alignment = .center
        openButton.stopProgress()
    }
    
    private func setupPopOver() {
        popOver = NSPopover()
        let popupContent = AppSelectionView()
            .environmentObject(peersManager)
        let vc = NSHostingController(rootView: popupContent)
        popOver!.contentViewController = vc
        popOver!.contentSize = CGSize(width: 550, height: 250)
        popOver!.behavior = .transient
    }
    
    private func startLoadingAnimation() {
        guard isSearchingForPeers else { return }
        NSAnimationContext.runAnimationGroup({ animation in
            animation.duration = 20
            openButton.updateProgress(progress: 1)
        }) {
            NSAnimationContext.runAnimationGroup({ animation in
                animation.duration = 0.1
                self.openButton.updateProgress(progress: 0)
            }) {
                self.startLoadingAnimation()
            }
        }
    }
    
    private func peerConnected() {
        popOver?.close()
        guard let peer = peersManager.connectedPeer else { return }
        if let data = peer.appInfo?.appIcon, let image = NSImage(data: data) {
            let smallImage = image.resize(withSize: NSSize(width: 14, height: 14))
            openButton.image = smallImage
            openButton.imagePosition = .imageLeading
            openButton.imageScaling = .scaleProportionallyDown
        } else {
            let image = NSImage(named: "noIcon")
            let smallImage = image?.resize(withSize: NSSize(width: 14, height: 14))
            openButton.image = smallImage
            openButton.imagePosition = .imageLeading
            openButton.imageScaling = .scaleProportionallyDown
        }
        openButton.alignment = .left
        openButton.title = "\(peer.displayName) - Connected"
    }
    
    @objc private func peerDisconnected() {
        guard let peer = peersManager.connectedPeer else { return }
        openButton.alignment = .left
        openButton.title = "\(peer.displayName) - Disconnected"
    }
    
    @IBAction func openAppSelection(sender: NSButton) {
        if popOver == nil {
            setupPopOver()
        }
        popOver?.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        
    }
    
    @IBAction func trashClicked(sender: NSButton) {
        (contentViewController as! TabsViewController).clearLogsFromTabs()
    }
    
    @IBAction func rightSidebarToggleClicked(sender: NSButton) {
        toolBarManager.showRightView.send(sender.state == .on)
    }
    
    @IBAction func lefttSidebarToggleClicked(sender: NSButton) {
        toolBarManager.showLeftView.send(sender.state == .on)
    }
}
