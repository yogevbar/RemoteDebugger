//
//  LogDetails.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 15/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct LogDetails: View {
    
    let log: Log
    
    var body: some View {
        VStack {
            LogDetailsLine(key: "Message", value: log.message)
            LogDetailsLine(key: "Level", value: log.level.name)
            LogDetailsLine(key: "Tags", value: "list")
            LogDetailsLine(key: "Function", value: "\(log.function.name)()")
            LogDetailsLine(key: "Line", value: "\(log.line)")
            LogDetailsLine(key: "Thread", value: log.thread)
            LogDetailsLine(key: "Date", value: log.date.description)
            Spacer()
        }
    }
}

struct LogDetailsLine: View {
    
    let key: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(key)
                Spacer()
                Text(value)
            }
            .padding([.leading, .trailing], 8)
            Divider()
        }
    }
}

struct LogDetails_Previews: PreviewProvider {
    static var previews: some View {
        LogDetails(log: LogsTestData.getLog())
    }
}
