//
//  LeftMenu.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct LevelModel {
    let level: Level
    let isSelected: Bool
}

struct LeftMenu: View {
    
    @EnvironmentObject private var session: SessionViewModel
    @EnvironmentObject private var oldSessionsManager: OldSessionsManager
    
    @State private var showLevels = true
    @State private var showTags = true
    
    @State private var showSessions = true
    
    var openSession: (_ sessionId: String) -> Void
    
    let leadingSpace: CGFloat = 18
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            //MARK: Levels
            MenuSectionHeader(showSection: $showLevels, title: "Level", image: "levels")
            
            if showLevels {
                Levels(levels: Level.allCases, selectedLevels: session.selectedLevels) { level in
                    self.session.addLevel(level: level)
                }                                
            }
                        
            //MARK: Tags
            if !session.tags.isEmpty {
                MenuSectionHeader(showSection: $showTags, title: "Tags", image: "tag")
                .padding(.top, 10)
                if showTags {
                    Tags(tags: session.tags, selectedTags: session.selectedTags) { tag in
                        self.session.addTagFilter(tag: tag)
                    }
                }
            }
            
            //MARK: Sessions
            if !oldSessionsManager.oldSessions.isEmpty {
                MenuSectionHeader(showSection: $showSessions, title: "Previous Session", image: "history")
                    .padding(.top, 10)
                if showSessions {
                    ForEach(oldSessionsManager.oldSessions.reversed(), id: \.id) { item in
                        Text(item.stringDate())
                        .onTapGesture {
                            self.openSession(item.id)
                        }
                    }
                    .padding(.leading, leadingSpace)
                }
            }
        }
    }

    
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu(openSession: { _ in })
    }
}
