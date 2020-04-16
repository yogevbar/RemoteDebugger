//
//  RootHostingController.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 10/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Cocoa
import SwiftUI

class RootHostingController: NSHostingController<AnyView> {

    @objc required dynamic init?(coder: NSCoder) {
        super.init(coder: coder, rootView: AnyView(ContentView().environmentObject(LogsManager())))
    }
    
}
