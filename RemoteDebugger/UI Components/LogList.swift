//
//  LogList.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct LogList: View {
    
    var logs: [Log]
    @State private var currentLog: Log?
    
    var body: some View {
        GeometryReader { metrics in
            HStack {
                if self.logs.count > 0 {
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(self.logs) { log in
                            LogView(log: log, currentLog: self.$currentLog)
                                .frame(height: 80)
                        }
                        .padding(.bottom, 15)
                    }
                    .padding(.top, 2)
                }
                if self.currentLog != nil && self.logs.count > 0 {
                    Divider()
                    LogDetails(log: self.currentLog!)
                        .frame(width: metrics.size.width * 0.3)
                        .padding()
                }
            }
        }
    }
}

struct LogList_Previews: PreviewProvider {
    static var previews: some View {
        LogList(logs: LogsTestData.createLogs())
    }
}
