//
//  TagsList.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct TagsList: View {
    
    @EnvironmentObject private var session: SessionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if !session.tags.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(session.tags, id: \.id) { item in
                        TagView(title: item.tag.name, isSelected: self.session.selectedTags.contains(item.tag), count: item.count)
                            .onTapGesture {
                                self.session.addTagFilter(tag: item.tag)
                        }
                    }
                }
            }
        }
        .padding(.leading, 15)
        .padding(.top, 5)
    }
}

struct TagsList_Previews: PreviewProvider {
    static var previews: some View {
        TagsList()
    }
}
