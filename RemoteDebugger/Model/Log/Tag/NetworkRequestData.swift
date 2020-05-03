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
    
    /** Status code */
    public let statusCode: Int
    
    /** Body of the request */
    public let body: Data?
    
    /** The data from the response */
    public let data: Data?
    
    /** Response error */
    public let error: String?
    
    
    // MARK: - Setup
    
    /** Initialize with URLRequest object */
    public init(request: URLRequest, response: URLResponse?, data: Data?, error: Error?, extractHeaderFields: Bool = true, extractBody: Bool = true) {
        method = request.httpMethod ?? "unspecified"
        url = request.url
        headerFields = extractHeaderFields ? request.allHTTPHeaderFields ?? [:] : [:]
        body = extractBody ? request.httpBody : nil
        self.data = data
        self.statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        self.error = error?.localizedDescription ?? nil
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
