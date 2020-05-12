//
//  NetworkLogDetailsView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 26/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct NetworkLogDetailsView: View {
    
    let network: HTTPNetworkRequestData
    
    struct Keys {
        struct OverView {
            static let url = "URL"
            static let method = "Method"
            static let statusCode = "Status code"
            static let requsetStartTime = "Requset start time"
            static let duration = "Duration"
        }
        
        struct Sections {
            static let overview = "Overview"
            static let headers = "Headers"
            static let requestBody = "Request Body"
            static let responseBody = "Response Body"
        }
        
    }
    
    var body: some View {
        
        let headerKeys = network.headerFields.map{$0.key}
        let headerValues = network.headerFields.map {$0.value}
        
        return Form {
            Section(header: LogDetailsHeaderView(title: Keys.Sections.overview)){
                LogDetailsLine(key: Keys.OverView.url, value: network.url?.absoluteString ?? "")
                LogDetailsLine(key: Keys.OverView.method, value: network.method)
                LogDetailsLine(key: Keys.OverView.statusCode, value: "\(network.statusCode)")
            }
            
            Section(header: LogDetailsHeaderView(title: Keys.Sections.headers)){
                ForEach(headerKeys.indices,id: \.self) { index in
                    LogDetailsLine(key: headerKeys[index], value: "\(headerValues[index])")
                }
            }
            
            if network.body != nil {
                Section(header: LogDetailsHeaderView(title: Keys.Sections.requestBody)){
                    MacEditorTextView(text: network.body!.prettyJson(), isEditable: false, font:
                        .systemFont(ofSize: 12))
                    .frame(minHeight: 100)
                }
            }
            
            if network.data != nil {
                Section(header: LogDetailsHeaderView(title: Keys.Sections.responseBody)){
                    MacEditorTextView(text: network.data!.prettyJson(), isEditable: false, font: .systemFont(ofSize: 12))                  
                }
            }
        }
    }
}

struct LogDetailsHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
        .font(.caption)
            .fontWeight(.bold)
        .padding(.bottom, 10)
    }
}

//struct NetworkLogDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkLogDetailsView()
//    }
//}
