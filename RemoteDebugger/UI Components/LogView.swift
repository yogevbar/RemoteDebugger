//
//  LogView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct LogView: View {
    
    let log: Log
    @EnvironmentObject private var session: SessionViewModel
    @EnvironmentObject private var toolBarManager: ToolBarManager
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color("\(log.level.name)-start"), Color("\(log.level.name)-end")]), startPoint: .top, endPoint: .bottom))
                .frame(width: 6, alignment: .leading)
                .padding([.leading, .trailing], 8)
                .padding([.top, .bottom], 6)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(log.message)
                            .fontWeight(.bold)
                        Text("-> \(log.file.description) (\(log.line))")
                    }
                    .padding([.trailing])
                    .padding([.top, .bottom], 8)
                    .padding(.leading, 4)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("2s")
                            .font(.caption)
                        HStack {
                            ForEach(log.tagsList, id: \.id) { item in
                                TagView(title: item.tag.name, isSelected: false, count: 0)
                            }.id(UUID())
                        }
                    }
                    .padding([.top, .bottom], 8)
                    .padding([.trailing])
                }
            }
        }
            
        .background(Color(log == session.selectedLog ? "selectedLevelBackground" : "logBackground"))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("logBackgroundBorder"),lineWidth: 1)
        )
            .padding([.leading, .trailing], 15)
            .onTapGesture { self.selectDeselect(self.log) }
//            .animation(.linear(duration: 0.2))
    }
    
    func selectDeselect(_ log: Log) {
        if session.selectedLog == log {
            session.selectedLog = nil
        } else {
            session.selectedLog = log
        }
        toolBarManager.rightViewIsEnabled.send(session.selectedLog != nil)
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {        
        LogView(log: Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date()))
    }
}
