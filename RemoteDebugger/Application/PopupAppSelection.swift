//
//  PopupAppSelection.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Cocoa
import SwiftUI

class PopupAppSelection: NSHostingController<AppSelectionView> {

    @objc required dynamic init?(coder: NSCoder) {
        super.init(coder: coder, rootView: AppSelectionView())
    }
    
}
