//
//  TextView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 21/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI
import AppKit

struct TextView : NSViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(<#T##control: TextView##TextView#>)
//    }
    
    
    typealias NSViewType = NSTextView
    @State var text: String
    
    func makeNSView(context: Context) -> NSTextView {
        let view = NSTextView()
        view.isEditable = false
        view.backgroundColor = .clear
        return view
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.string = text
    }
    
//    class Coordinator: NSObject, NSTextViewDelegate {
//        var control: TextView
//
//        init(_ control: TextView) {
//            self.control = control
//        }
//
////        func textViewDidChange(_ textView: UITextView) {
////            control.model.text = textView.text
////        }
//    }
}

