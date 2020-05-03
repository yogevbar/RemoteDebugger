//
//  String+Extensions.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 22/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

extension String {
    func prettyJson() -> String {
        var result = ""
        let string = replacingOccurrences(of: "\\", with: "")
        guard let jsonData = string.data(using: .utf8) else { return result }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            if let string = String(data: prettyJsonData, encoding: .utf8) {
                result = string
            } else {
                return result
            }
        } catch {
            return result
        }
        
        return result
    }
}

extension Data {
    func prettyJson() -> String {
        var result = ""
                        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            if let string = String(data: prettyJsonData, encoding: .utf8) {
                result = string
            } else {
                return result
            }
        } catch {
            return String(data: self, encoding: .utf8) ?? result
        }
        
        return result
    }
}
