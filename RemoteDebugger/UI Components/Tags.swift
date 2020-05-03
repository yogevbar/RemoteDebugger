//
//  Tags.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 02/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct Tags: View {
    
    let tags: [TagModel]
    let selectedTags: [Tag]
    let tagSelected: TagSelectedCompletion
    let leadingSpace: CGFloat = 18
    
    typealias TagSelectedCompletion = (_ tag: Tag) -> Void
    
    var body: some View {
        ForEach(tags, id: \.id) { item in
            TagView(title: item.tag.name, isSelected: self.selectedTags.contains(item.tag), count: item.count)
                .onTapGesture {
                    self.tagSelected(item.tag) //self.logsManager.addTagFilter(tag: item.tag)
            }
        }
        .padding(.leading, leadingSpace)
        .padding(.bottom, 8)
    }
}

struct Tags_Previews: PreviewProvider {
    static var previews: some View {
        Tags(tags: [], selectedTags: [], tagSelected: { _ in })
    }
}
