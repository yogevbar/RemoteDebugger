//
//  LogModel.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

struct LogModel: Identifiable {
    var id: String = UUID().uuidString
    
    let title: String
}
