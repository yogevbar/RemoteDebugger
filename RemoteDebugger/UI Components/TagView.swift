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
    
    var body: some View {
        Text(title)
        .layoutPriority(1)
            .padding()
            .background(isSelected ? Color("selectedTag") : Color("unselectedTag"))
            .frame(height: 27)
            .cornerRadius(8)
        
        
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        TagView(title: "test title", isSelected: false)
    }
}
