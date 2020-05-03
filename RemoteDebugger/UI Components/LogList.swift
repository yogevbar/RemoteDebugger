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
    
    var body: some View {
            HStack {
                if self.logs.count > 0 {
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(self.logs) { log in
                            LogView(log: log)
                                .frame(height: 80)
                        }
                        .padding(.bottom, 15)
                    }
                    .padding(.top, 2)
                }
            }
    }
}

struct LogList_Previews: PreviewProvider {
    static var previews: some View {
        LogList(logs: LogsTestData.createLogs())
    }
}
