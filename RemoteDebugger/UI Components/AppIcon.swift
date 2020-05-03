//
//  AppIcon.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct AppIcon: View {
    
    var userStatus: PeerStatus
    @State var image: NSImage?    
    
    var body: some View {
        
        print(userStatus)
        
        switch userStatus {
        case .connected:
            return AppIconImage(image: image)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .trim(from: 0, to: 1)
                        .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("appIconBorder"))
                        .rotationEffect(Angle(degrees: -90.0))
                        .animation(.linear)
            )
        case .connecting:
            return AppIconImage(image: image)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .trim(from: 0, to: 1)
                        .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("appIconBorder"))
                        .rotationEffect(Angle(degrees: -90.0))
                        .animation(.linear(duration: 3.0))
            )
        case .disconnected:
            return AppIconImage(image: image)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .trim(from: 0, to: 0)
                        .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("appIconBorder"))
                        .rotationEffect(Angle(degrees: -90.0))
                        .animation(.linear)
            )
        }
    }
}
