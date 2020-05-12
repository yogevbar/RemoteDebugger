//
//  Level.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct LevelView: View {
    
    var isSelected: Bool
    let title: String
    let startColor: Color
    let endColor: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .top, endPoint: .bottom))
                .frame(width: 15, height: 15)
            Text(title.uppercased())            
                .fontWeight(.regular)
                .padding(.leading, 10)
        }
        .padding(6)
        .background(isSelected ? Color("selectedLevelBackground") : Color.clear)
        .cornerRadius(4)
        .contentShape(Rectangle())
    }
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(isSelected: false, title: "ALL", startColor: .red, endColor: .pink)
    }
}
