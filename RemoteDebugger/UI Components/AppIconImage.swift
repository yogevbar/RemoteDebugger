//
//  SwiftUIView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct AppIconImage: View {
    
    var image: NSImage?
    
    var body: some View {
        ZStack {
            if image != nil {
                Image(nsImage: image!)
            } else {
                Image("noIcon")
            }
        }
        
    }
}
