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
    @State private var showingAlert = false
    
    struct Keys {
        struct LogDetails {
            static let message = "Message"
            static let level = "Level"
            static let tags = "Tags"
            static let function = "Function"
            static let line = "Line"
            static let thread = "Thread"
            static let date = "Date"
        }
        
        struct Sections {
            static let logDetails = "Log details"
            static let developerData = "Developer Data"
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Form {
                    Section(header: LogDetailsHeaderView(title: Keys.Sections.logDetails)){
                        LogDetailsLine(key: Keys.LogDetails.message, value: log.message)
                        LogDetailsLine(key: Keys.LogDetails.level, value: log.level.name)
                        LogDetailsLine(key: Keys.LogDetails.tags, value: "list")
                        LogDetailsLine(key: Keys.LogDetails.function, value: "\(log.function.name)()")
                        LogDetailsLine(key: Keys.LogDetails.line, value: "\(log.line)")
                        LogDetailsLine(key: Keys.LogDetails.thread, value: log.thread)
                        LogDetailsLine(key: Keys.LogDetails.date, value: log.date.description)
                    }
                    
                    if !log.developerData.isEmpty {
                        Section(header: LogDetailsCopySection(title: Keys.Sections.developerData, data: log.description)){
                            containedView()
                        }
                        
                    }
                }
                Spacer()
            }.padding()
        }
    }
    
    func containedView() -> AnyView {
        switch log.developerDataType {
        case .network(let newtorkData):
            return AnyView(NetworkLogDetailsView(network: newtorkData))
        case .unknown: return AnyView(MacEditorTextView(text: log.developerData.prettyJson(), isEditable: false, font: .systemFont(ofSize: 12)))
        }
    }
}

struct LogDetailsCopySection: View {
    let title: String
    let data: String
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
                pasteboard.setString(self.data, forType: NSPasteboard.PasteboardType.string)
            }) {
                Image("copy")
            }            
        }.padding(.bottom, 10)
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
            .opacity(0.8)
            Divider()
        }
    }
}

struct LogDetails_Previews: PreviewProvider {
    static var previews: some View {
        LogDetails(log: LogsTestData.getLog())
    }
}
