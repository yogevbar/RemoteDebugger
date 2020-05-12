//
//  Levels.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 02/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct Levels: View {
    
    let levels: [Level]
    var selectedLevels: [Level]
    let leadingSpace: CGFloat = 18
    let levelSelected: (_ level: Level?) -> Void
    
    typealias LevelSelectedCompletion = (Level) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            LevelView(isSelected: selectedLevels.isEmpty, title: "all", startColor: Color.white, endColor: Color.white)
                .onTapGesture {
                    self.levelSelected(level: nil)
            }
            .padding(.leading, leadingSpace)
            ForEach(levels, id: \.name) { level in
                LevelView(isSelected: self.selectedLevels.contains(level), title: level.name, startColor: Color("\(level.name)-start"), endColor: Color("\(level.name)-end"))
                    .onTapGesture {
                        self.levelSelected(level: level)
                }
            }
                
            .padding(.leading, leadingSpace)
        }
    }
    
    private func levelSelected(level: Level?) {
        levelSelected(level)
    }
}

struct Levels_Previews: PreviewProvider {
    static var previews: some View {
        Levels(levels: [.verbose, .debug, .info, .warning, .error], selectedLevels: [.verbose], levelSelected: { _ in })
    }
}
