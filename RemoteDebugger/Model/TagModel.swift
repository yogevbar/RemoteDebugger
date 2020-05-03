//
//  Tag.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 11/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import SwiftUI

struct TagModel: Identifiable, Decodable {
    
    /// unique id
    var id: String = UUID().uuidString
    let tag: Tag
    let count: Int
}
