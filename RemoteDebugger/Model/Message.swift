//
//  Message.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 07/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

public struct Message: Codable {
    
    public enum MessageType: String, Codable {
        case bindCommand
        case startSessionWithSession
        case infoWithAppInfo
        case archiveSessionWithIdCommand
        case archiveSessionWithSession        
        case archiveSessionsWithPrevSessionsDetails
        case logWithLogInfo
    }
    
    public let type: MessageType
    public let payload: Any?
    
    private enum CodingKeys: String, CodingKey {
      case type
      case payload
    }
    
    init(type: MessageType, payload: Any? = nil) {
        self.type = type
        self.payload = payload
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(MessageType.self, forKey: .type)

        if let decode = Message.decoders[type.rawValue] {
            payload = try decode(container)
        } else {
            payload = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)

        if let payload = self.payload {
            guard let encode = Message.encoders[type.rawValue] else {
                let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid attachment: \(type).")
                throw EncodingError.invalidValue(self, context)
            }

            try encode(payload, &container)
        } else {
            try container.encodeNil(forKey: .payload)
        }
    }
    
    // MARK: Registration
    private typealias AttachmentDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    private typealias AttachmentEncoder = (Any, inout KeyedEncodingContainer<CodingKeys>) throws -> Void

    private static var decoders: [String: AttachmentDecoder] = [:]
    private static var encoders: [String: AttachmentEncoder] = [:]

    static func register<A: Codable>(_ type: A.Type, for typeName: String) {
        decoders[typeName] = { container in
            try container.decode(A.self, forKey: .payload)
        }

        encoders[typeName] = { payload, container in
            try container.encode(payload as! A, forKey: .payload)
        }
    }
}

extension Message {
    static func register() {
        Message.register(Log.self, for: "logWithLogInfo")
        Message.register(SessionInfo.self, for: "startSessionWithSession")
        Message.register([SessionPresentableInfo].self, for: "archiveSessionsWithPrevSessionsDetails")
        Message.register(SessionInfo.self, for: "archiveSessionWithSession")
        Message.register(AppInfo.self, for: "infoWithAppInfo")
        Message.register(String.self, for: "archiveSessionWithIdCommand")
    }
}
