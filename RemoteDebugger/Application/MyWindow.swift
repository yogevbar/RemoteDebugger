//
//  MyWindow.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine

class MyWindow: NSWindow {
    
    @IBOutlet weak var openButton: NSButton!
    @IBOutlet weak var rightSidebarToggle: NSButton! {
        didSet {
            rightSidebarToggle.isEnabled = false
        }
    }
    @IBOutlet weak var leftSidebarToggle: NSButton!
    
    var popOver: NSPopover?
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        NotificationCenter.default.addObserver(self, selector: #selector(peerConnected(notification:)), name: .peerConnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(peerDisconnected(notification:)), name: .peerDisconnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(peerConnecting(notification:)), name: .peerConnecting, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rightSideEnabled(notification:)), name: .rightSidebarEnabled, object: nil)
        toolbar?.showsBaselineSeparator = false
    }
    
    private func setupPopOver() {
        popOver = NSPopover()
        let popupContent = AppSelectionView()
        let vc = NSHostingController(rootView: popupContent)
        popOver!.contentViewController = vc
        popOver!.contentSize = CGSize(width: 550, height: 250)
        popOver!.behavior = .transient
    }
    
    @objc func peerConnecting(notification: Notification) {
        popOver?.close()
    }

    @objc private func peerConnected(notification: Notification) {
        guard let peer = notification.object as? Peer else { return }
        if let image = peer.appIcon {
            let smallImage = image.resize(withSize: NSSize(width: 14, height: 14))
            openButton.image = smallImage
            openButton.imagePosition = .imageTrailing
            openButton.imageScaling = .scaleProportionallyDown
        }
        openButton.alignment = .left
        openButton.title = peer.displayName
        popOver?.close()
    }
    
    @objc private func peerDisconnected(notification: Notification) {
        openButton.alignment = .center
        openButton.title = "Choose an app to debug"
        openButton.image = NSImage(named: NSImage.refreshTemplateName)
    }
    
    @IBAction func openAppSelection(sender: NSButton) {
        if popOver == nil {
            setupPopOver()
        }
        popOver?.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        
    }
    
    @IBAction func trashClicked(sender: NSButton) {
        NotificationCenter.default.post(name: .cleanLogs, object: nil)
    }
    
    @IBAction func rightSidebarToggleClicked(sender: NSButton) {
        let toggle = Toggles(toggle: sender.state == .on)
        NotificationCenter.default.post(name: .rightSidebarToggle, object: toggle)
    }
    
    @IBAction func lefttSidebarToggleClicked(sender: NSButton) {
        let toggle = Toggles(toggle: sender.state == .on)        
        NotificationCenter.default.post(name: .leftSidebarToggle, object: toggle)
    }

    @objc func rightSideEnabled(notification: Notification) {
        guard let toggle = notification.object as? Toggles else {
            return
        }
        
        rightSidebarToggle.isEnabled = toggle.toggle
        rightSidebarToggle.setNextState()        
        NotificationCenter.default.post(name: .rightSidebarToggle, object: toggle)
    }
}

struct Toggles {
    var toggle: Bool
}

