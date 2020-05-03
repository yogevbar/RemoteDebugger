//
//  ContentView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 10/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject private var session: SessionViewModel
    @EnvironmentObject private var toolBarManager: ToolBarManager
    @State private var selection: String?
    @State private var showDetailsView = false
    
    var openSession: (_ sessionId: String) -> Void
    
    var body: some View {
        HSplitView {
            if toolBarManager.showMenu {
                List(selection: $selection) {
                    LeftMenu(openSession: { sessionId in
                        self.openSession(sessionId)
                    })
                        .padding(.top, 15)
                    Spacer()
                }
                .background(Color("background"))
                .listStyle(SidebarListStyle())
                .frame(minWidth: 190, idealWidth: 190, maxWidth: 220)
                
            }
            HSplitView {
                VStack(alignment: .leading) {
                    SearchBar(text: $session.searchKey)
                        .padding([.leading, .trailing])
                        .layoutPriority(2)
                    
                    LogList(logs: session.filteredLogs)
                    Spacer()
                }
                .padding(.top, 15)
                .frame(minWidth: 400)
                if !toolBarManager.showDetails && session.selectedLog != nil {
                    LogDetails(log: session.selectedLog!)
                        .frame(minWidth: 200)
                }
                
            }//.animation(.easeInOut)
            
        }
        .frame(minWidth: 800, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(openSession: { _ in })
    }
}
