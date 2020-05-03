//
//  AppInfo.swift
//  Antelope
//
//  Created by Daniel Huri on 1/12/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

public protocol BundleDataProtocol {
    
    /** Raw bundle identifier */
    var identifier: String { get }
    
    /** Raw bundle version */
    var version: String { get }
    
    /** Raw build number */
    var build: String { get }
    
    /** Raw bundle name (human readable) */
    var name: String { get }
}

/** Contains relevant info about the target */
public struct AppInfo: Codable {
    
    // MARK: Types
    
    public struct BundleData: BundleDataProtocol {
        
        // MARK: - Properties
        
        public let identifier: String
        public let version: String
        public let build: String
        public let name: String
        
        // MARK: - Setup
        
        public init(from bundle: Bundle = .main) {
            identifier = bundle.bundleIdentifier ?? ""
            version = bundle.infoDictionary?[kCFBundleInfoDictionaryVersionKey as String] as? String ?? ""
            build = bundle.infoDictionary?[kCFBundleVersionKey as String] as? String ?? "0"
            name = bundle.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
        }
    }
    
    /** The platform of the machine */
    public enum Platform: String, Codable {
        
        /** Simulator */
        case simulator
        
        /** Real device */
        case device
    }
    
    // MARK: - Properties
    
    /** Bundle identifier */
    public let identifier: String
    
    /** Bundle name */
    public let name: String
    
    /** App version components, at integers */
    public let version: [Int]
    
    /** Build number */
    public let build: Int
    
    /** Platform indicator */
    public let platform: Platform
    
    /** The version as string in the format: "x.y.z" */
    public var stringVersion: String {
        return version.map { String($0) }.joined(separator: ".")
    }
    
    /** Initializer
     - parameter bundle: A bundle from which the app info should be extracted
     */
    public init(with info: BundleDataProtocol = BundleData()) {
        version = info.version.components(separatedBy: ".").map { Int($0) ?? 0 }
        build = Int(info.build) ?? 0
        identifier = info.identifier
        name = info.name
        #if arch(i386) || arch(x86_64)
        platform = .simulator
        #else
        platform = .device
        #endif
    }
}

// MARK: - Printable

extension AppInfo: Printable {
    public var pretty: String {
        let string =
        """
        Identifier: \(identifier)
        Name: \(name)
        Version: \(stringVersion) (\(build))
        Platform: \(platform)
        """
        return prettyFormat(string: string)
    }
    
    var json: String {
        return jsonString
    }
}

// MARK: - Comparable

extension AppInfo: Comparable { }

public func ==(left: AppInfo, right: AppInfo) -> Bool {
    return left.version == right.version && left.build == right.build
}

public func <(left: AppInfo, right: AppInfo) -> Bool {
    var leftComponents = left.version
    var rightComponents = right.version
    
    while leftComponents.count < rightComponents.count {
        leftComponents.append(0)
    }
    
    while rightComponents.count < leftComponents.count {
        rightComponents.append(0)
    }
    
    leftComponents.append(left.build)
    rightComponents.append(right.build)
    
    for (leftNumber, rightNumber) in zip(leftComponents, rightComponents) {
        if leftNumber == rightNumber {
            continue
        } else {
            if leftNumber < rightNumber {
                return true
            }
            return false
        }
    }
    return false
}

public func <=(left: AppInfo, right: AppInfo) -> Bool {
    return left < right || left == right
}

