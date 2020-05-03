//
//  PeerView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 22/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct PeerView: View {
            
    @ObservedObject private var viewModel = PeersManager()
    @State private var hover = false
    @State var peer: Peer
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                AppIcon(userStatus: peer.status, image: peer.appIcon)
            }
            Text(peer.displayName)
        }
        .padding(8)
        .background(self.hover ? Color.black.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        .onTapGesture {
            self.viewModel.connectToPeer(peer: self.peer)
        }
        .onHover {_ in
            self.hover.toggle()
        }
    }
}

struct PeerView_Previews: PreviewProvider {
    static var previews: some View {
        PeerView(peer: Peer(displayName: "test"))
    }
}
