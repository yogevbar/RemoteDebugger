//
//  TagsList.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct TagsList: View {
    
    @EnvironmentObject private var logsManager: LogsManager
    
    var body: some View {
        HStack {
            Text(logsManager.tags.isEmpty ? "" : "Tags")
                .fontWeight(.bold)
            if !logsManager.tags.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 10) {
                        ForEach(logsManager.tags, id: \.id) { item in
                            TagView(title: item.tag.name, isSelected: self.logsManager.selectedTags.contains(item.tag))
                                .onTapGesture {
                                    self.logsManager.addTag(tag: item.tag)
                            }
                        }
                    }
                }
                .padding(.trailing, 15)
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
