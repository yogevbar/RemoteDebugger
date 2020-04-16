//
//  NetworkRequestData.swift
//  AntelopeDemo
//
//  Created by Daniel Huri on 1/19/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

public struct HTTPNetworkRequestData: Codable {
    
    // MARK: - Properties
    
    /** HTTP method */
    public let method: String
    
    /** The url */
    public let url: URL?
    
    /** Headers of the request */
    public let headerFields: [String: String]
    
    /** Body of the request */
    public let body: Data?
    
    // MARK: - Setup
    
    /** Initialize with URLRequest object */
    public init(request: URLRequest, extractHeaderFields: Bool = true, extractBody: Bool = true) {
        method = request.httpMethod ?? "unspecified"
        url = request.url
        headerFields = extractHeaderFields ? request.allHTTPHeaderFields ?? [:] : [:]
        body = extractBody ? request.httpBody : nil
    }
}

public struct HTTPNetworkResponseData: Codable {
    
    // MARK: - Properties
    
    public let statusCode: Int
    public let url: URL?
    
    public init(response: HTTPURLResponse) {
        statusCode = response.statusCode
        url = response.url
    }
}
