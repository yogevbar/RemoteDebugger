//
//  UUID+Get.swift
//  Antelope
//
//  Created by Daniel Huri on 12/15/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

extension UUID {
    static var random: String {
        return UUID().uuidString
    }
}
