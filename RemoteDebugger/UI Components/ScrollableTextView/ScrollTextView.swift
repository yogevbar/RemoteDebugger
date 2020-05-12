//
//  TextView.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 12/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import SwiftUI

struct ScrollTextView: NSViewRepresentable {
    @State var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> ScrollableTextView {
        var views: NSArray?
        Bundle.main.loadNibNamed("ScrollableTextView", owner: nil, topLevelObjects: &views)
        let scrollableTextView = views!.compactMap({ $0 as? ScrollableTextView }).first!
        scrollableTextView.textView.delegate = context.coordinator
        return scrollableTextView
    }

    func updateNSView(_ nsView: ScrollableTextView, context: Context) {
        guard nsView.textView.string != text else { return }
        nsView.textView.string = text
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        let parent: ScrollTextView

        init(_ textView: ScrollTextView) {
            self.parent = textView
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            self.parent.text = textView.string
        }
    }
}
