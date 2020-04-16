//
//  LogManager.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 15/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class LogsManager: ObservableObject {
    
    //MARK: privates
    private let networking = NetworkServiceManager.shared
    private var allLogs = [Log]() {
        didSet {
            updateFilters()
        }
    }
    
    //MARK: data sources
    @Published var logs = [Log]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var selectedLevels = [Level]() {
        didSet {
            updateFilters()
        }
    }
    @Published var selectedTags = [Tag]() {
        didSet {
            updateFilters()
        }
    }
    @Published var searchKey: String = "" {
        didSet {
            updateFilters()
        }
    }
    private var tagsList = Set<Tag>() {
        didSet {
            tags = tagsList.map { TagModel(tag: $0) }
        }
    }
    
    @Published var tags = [TagModel]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        initClousers()
        networking.startScanForConnection()
    }
    
    private func addLog(log: Log) {
//        print("Log recived: \(log.message)")
        tagsList.insert(log.tags)
        allLogs.append(log)
    }
    
    private func addCachedLogs(logs: [Log]) {
        
    }
    
    private func messageRecived(message: Codable) {
        guard let message = message as? Message else { return }
        switch message.type {
        case .log:
            addLog(log: message.log!)
        case .cached:
            addCachedLogs(logs: message.cached!)
        default:
            break
        }
    }
    
    private func updateFilters() {
        DispatchQueue.global(qos: .background).async {
            let filteredLogs = self.allLogs.filters(levels: self.selectedLevels, tags: self.selectedTags, searchKey: self.searchKey)
            DispatchQueue.main.async {
                self.logs = filteredLogs
                self.objectWillChange.send()
            }
            
        }
    }
    
    func addLevel(level: Level?) {
        if let level = level {
            if let index = selectedLevels.firstIndex(of: level) {
                selectedLevels.remove(at: index)
            } else {
                selectedLevels.append(level)
            }
        } else {
            selectedLevels = []
        }
    }
    
    func addTag(tag: Tag) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }
}

extension LogsManager {
    private func initClousers() {
        networking.messageRecived = { [weak self] (message: Codable) in
            self?.messageRecived(message: message)
        }
    }
}

extension Array where Element == Log {
    func filters(levels: [Level], tags: [Tag], searchKey: String) -> [Log] {
        return filter{
            (levels.isEmpty || levels.contains($0.level)) &&
                (tags.isEmpty || tags.allSatisfy($0.tags.contains)) &&
                (searchKey .isEmpty || $0.description.contains(searchKey)) }
    }
}


