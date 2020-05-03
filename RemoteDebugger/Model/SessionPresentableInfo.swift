//
//  SessionPresentableInfo.swift
//  AntelopeDemo
//
//  Created by Daniel Huri on 2/8/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

public struct SessionPresentableInfo {
    public let url: URL
    public let date: Date
    public let id: String
    
    
    public init(url: URL, date: Date, id: String) {
        self.url = url
        self.date = date
        self.id = id
    }
    
    func stringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

// MARK: Codable
extension SessionPresentableInfo: Codable { }

// MARK: - Comparable

extension SessionPresentableInfo: Comparable {
    public static func < (lhs: SessionPresentableInfo, rhs: SessionPresentableInfo) -> Bool {
        return lhs.date.compare(rhs.date) == .orderedAscending
    }
    
    public static func == (lhs: SessionPresentableInfo, rhs: SessionPresentableInfo) -> Bool {
        return lhs.date.compare(rhs.date) == .orderedSame
    }
}
