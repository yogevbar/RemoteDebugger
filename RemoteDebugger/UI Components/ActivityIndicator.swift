//
//  ActivityIndicator.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI
import Cocoa

struct ProgressView: NSViewRepresentable {
    
    let size: NSControl.ControlSize
    
    func updateNSView(_ nsView: NSProgressIndicator, context: NSViewRepresentableContext<ProgressView>) {
        nsView.style = .spinning
        nsView.controlSize = size
        nsView.startAnimation(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<ProgressView>) -> NSProgressIndicator {
        let progressIndicator = NSProgressIndicator()
        return progressIndicator
    }
    
}
