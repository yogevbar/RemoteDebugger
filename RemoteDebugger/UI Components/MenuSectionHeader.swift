//
//  MenuSectionHeader.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 02/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct MenuSectionHeader: View {
    
    @Binding var showSection: Bool
    
    let title: String
    let image: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 14)
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.bottom, 2)
                .padding(.top, 2)
            Spacer()
            Image("arrowUp")
                .rotationEffect(showSection ? Angle(degrees: 0) : Angle(degrees: 180))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.showSection.toggle()
        }
    }
}

struct MenuSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        MenuSectionHeader(showSection: .constant(true), title: "Test", image: "levels")
    }
}
