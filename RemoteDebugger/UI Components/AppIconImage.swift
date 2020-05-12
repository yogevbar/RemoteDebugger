//
//  SwiftUIView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct AppIconImage: View {
    
    var image: Data?
    static let imageSize: CGFloat = 32
    
    var body: some View {
        ZStack {
            if image != nil {
                Image(nsImage: (NSImage(data: image!) ?? NSImage(named: "noIcon"))!)
                .resizable()
                    .frame(width: AppIconImage.imageSize, height: AppIconImage.imageSize)
            } else {
                Image("noIcon")
                .resizable()
                .frame(width: AppIconImage.imageSize, height: AppIconImage.imageSize)
            }
        }
    }
}
