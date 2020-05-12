//
//  PeerView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 22/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct PeerView: View {
            
    @EnvironmentObject var peersManager: PeersManager
    @State private var hover = false
    @State var peer: NearbyDevice
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                AppIcon(userStatus: peer.state, image: peer.appInfo?.appIcon)
            }
            Text(peer.displayName)
            Spacer()
        }
            .onAppear {
                self.hover = false
            }
            .onHover { isHovered in
                self.hover = isHovered
                print("hover: \(self.hover)")
            }
        .padding(8)
        .background(self.hover ? Color.black.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        .onTapGesture {
            self.peersManager.connectToPeer(peer: self.peer)
        }
    }
}

//struct PeerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeerView(peer: Peer(displayName: "test"))
//    }
//}
