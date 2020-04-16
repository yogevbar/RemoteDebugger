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
    
    @EnvironmentObject private var logsManager: LogsManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Level")
                .font(.caption)
                .padding(.bottom, 2)
            LevelView(isSelected: logsManager.selectedLevels.isEmpty, title: "all", color: Color.white)
            .onTapGesture {
                    self.levelSelected(level: nil)
            }
            ForEach(Level.allCases, id: \.name) { level in
                LevelView(isSelected: self.logsManager.selectedLevels.contains(level), title: level.name, color: Color(level.name))
                    .onTapGesture {
                        self.levelSelected(level: level)
                }
            }
        }
    }
    
    private func levelSelected(level: Level?) {
        logsManager.addLevel(level: level)
    }
    
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu()
    }
}
