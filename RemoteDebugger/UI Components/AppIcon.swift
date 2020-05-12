//
//  AppIcon.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 14/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct AppIcon: View {
    
    var userStatus: NearbyDevice.State
    @State var image: Data?    
    
    var body: some View {
        
        AppIconImage(image: image)        
        
    }
}
