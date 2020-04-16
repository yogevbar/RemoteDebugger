//
//  ContentView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 10/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var logsManager: LogsManager
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading) {
                LeftMenu()
                Spacer()
            }
            .padding(.top, 15)
            .frame(width: 140)
            .background(Color("background"))
            
            
            VStack(alignment: .leading) {
                SearchBar(text: $logsManager.searchKey)
                    .padding([.leading, .trailing])
                TagsList()
                LogList(logs: logsManager.logs)
            }
            .padding(.top, 15)
        }
        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LogsManager())
    }
}
