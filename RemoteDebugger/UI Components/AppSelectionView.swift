//
//  AppSelectionView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct AppSelectionView: View {
    
    @ObservedObject private var viewModel = PeersManager()
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Discovered (\(viewModel.peers.count))")
                Spacer()
                Text("Can't see your app?")
            }
            if viewModel.peers.count == 0 {
                Text("No appliction found.")
                    .font(.title)
                    .opacity(0.3)
                    .padding(35)
            } else {
                HStack {
                    ForEach(viewModel.peers) { peer in
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                AppIcon(userStatus: peer.status, image: peer.appIcon)
                            }                                                        
                            Text(peer.displayName)
                        }.onTapGesture {
                            self.viewModel.connectToPeer(peer: peer)                            
                        }
                    }
                }
            }
        }
        .padding()
        .frame(width: 550)
    }
}

struct AppSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AppSelectionView()
    }
}
