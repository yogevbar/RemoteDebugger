//
//  SearchBar.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI
import Quartz

struct SearchBar : NSViewRepresentable {
    
    typealias NSViewType = NSSearchField
    
    @Binding var text : String
    
    class Cordinator : NSObject, NSSearchFieldDelegate {
        
        @Binding var text : String
        
        init(text : Binding<String>) {
            _text = text
        }
        
        func controlTextDidChange(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField else { return }
            let value = textField.stringValue
            text = value
        }
    }
    
    func updateNSView(_ nsView: NSSearchField, context: NSViewRepresentableContext<SearchBar>) {
        nsView.stringValue = text
    }
    
    func makeNSView(context: NSViewRepresentableContext<SearchBar>) -> NSSearchField {
        let searchBar = NSSearchField(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text)
    }
    
}
