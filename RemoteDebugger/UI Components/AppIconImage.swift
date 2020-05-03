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
                .resizable()
                .frame(width: 64, height: 64)
            } else {
                Image("noIcon")
                .resizable()
                .frame(width: 64, height: 64)
            }
        }
    }
}
