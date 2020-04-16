//
//  Codable.swift
//  Antelope
//
//  Created by Daniel Huri on 12/15/18.
//  Copyright © 2018 Antelope. All rights reserved.
//

import Foundation

extension Encodable {
    var jsonString: String {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(self) else {
            return ""
        }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            return ""
        }
        return jsonString
    }
}

extension Data {
    func decode<T: Decodable>(to type: T.Type) -> T? {
        do {
            let response = try JSONDecoder().decode(type, from: self)
            return response
        } catch {
            return nil
        }
    }
    
//    var fileData: SessionInfo? {
//        return decode(to: SessionInfo.self)
//    }
}

extension String {
    var data: Data? {
        return data(using: .utf8)
    }
}
