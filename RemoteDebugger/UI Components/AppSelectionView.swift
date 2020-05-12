//
//  AppSelectionView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct AppSelectionView: View {
    
    @EnvironmentObject var peersManager: PeersManager
    
    var body: some View {
        VStack(alignment: .center) {
//            HStack {
//                Text("Discovered (\(peersManager.availablePeers.count))")
//                Spacer()
//                Text("Can't see your app?")
//            }
//            .padding([.leading, .top, .trailing])
            if peersManager.availablePeers.count == 0 {
                Text("No appliction found.")
                    .font(.title)
                    .opacity(0.3)
                    .padding(35)
            } else {
                List {
                    ForEach(peersManager.availablePeers, id: \.self) { peer in
                        PeerView(peer: peer)
                    }
                }.listStyle(SidebarListStyle())
            }
        }
        .padding(.top)
        .frame(width: 550)
    }
}

struct AppSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AppSelectionView()
    }
}
