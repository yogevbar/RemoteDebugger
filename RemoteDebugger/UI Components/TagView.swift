//
//  Tag.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct TagView: View {
    
    let title: String
    let isSelected: Bool
    let count: Int
    
    var body: some View {
        Text("\(title)\(count == 0 ? "" : " (\(count))")")
        .layoutPriority(1)
            .padding()
            .background(isSelected ? Color("selectedTag") : Color("unselectedTag"))
            .frame(height: 27)
            .cornerRadius(8)
        
        
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        TagView(title: "test title", isSelected: false, count: 1)
    }
}
