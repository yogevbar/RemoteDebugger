//
//  Set+Extensions.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 16/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

extension Set {
    @discardableResult mutating func insert(_ newMembers: [Set.Element]) -> [(inserted: Bool, memberAfterInsert: Set.Element)] {
        var returnArray: [(inserted: Bool, memberAfterInsert: Set.Element)] = []
        newMembers.forEach { (member) in
            returnArray.append(self.insert(member))
        }
        return returnArray
    }
}
