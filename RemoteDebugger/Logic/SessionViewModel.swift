//
//  SessionViewModel.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 03/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SessionViewModel: ObservableObject {
    //MARK: Session
    var sessionDetails: SessionInfo
    
    //MARK: Logs
    private var logs: [Log] {
        didSet {
            update()
        }
    }
    @Published var filteredLogs = [Log]()
    @Published var selectedLog: Log? {
        didSet {
            NotificationCenter.default.post(name: .rightSidebarEnabled, object: Toggles(toggle: selectedLog != nil))
        }
    }
    private var cleanLogs = Set<String>() {
        didSet {
            update()
        }
    }
    
    //MARK: Levels
    @Published var selectedLevels = [Level]() {
        didSet {
            update()
        }
    }
        
    //MARK: Tags
    private var tagsList = [Tag: Int]() {
        didSet {
            DispatchQueue.main.async {
                self.tags = self.tagsList.map { TagModel(tag: $0.key, count: $0.value) }.sorted { $0.tag.name < $1.tag.name }
            }
            
        }
    }
    @Published var tags = [TagModel]()
    @Published var selectedTags = [Tag]() {
        didSet {
            update()
        }
    }
    
    //MARK: Search
    @Published var searchKey = ""
    
    init(sessionDetails: SessionInfo) {
        self.sessionDetails = sessionDetails
        self.logs = sessionDetails.logs
        update()
    }
    
    private func update() {
        DispatchQueue.global(qos: .background).async {
            var filtered = self.logs.filters(levels: self.selectedLevels, tags: self.selectedTags, searchKey: self.searchKey, hiddenLogs: self.cleanLogs)
            filtered.sort(by: { $0 > $1 })
            self.updateTags(logs: filtered)
            DispatchQueue.main.async {
                self.filteredLogs = filtered
                self.objectWillChange.send()
            }
        }
    }
 
    func addLog(log: Log?) {
        guard let log = log, !logs.contains(log) else { return }
        addTags(tags: log.tags)
        logs.append(log)
    }
    
    func addCachedLogs(logs: [Log]?) {
            guard let logs = logs else { return }
            
            logs.forEach { log in
                addLog(log: log)
            }
        }
    
    private func addTags(tags: [Tag]) {
        tags.forEach { tag in
            addTag(tag: tag)
        }
    }
    
    private func addTag(tag: Tag) {
        if tagsList[tag] != nil {
            tagsList[tag]! += 1
        } else {
            tagsList[tag] = 1
        }
    }
    
    private func updateTags(logs: [Log]) {
        var tempTags = [Tag: Int]()
        logs.forEach { log in
            log.tags.forEach { tag in
                if tempTags[tag] != nil {
                    tempTags[tag]! += 1
                } else {
                    tempTags[tag] = 1
                }
            }
        }
        tagsList = tempTags
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
        update()
    }
    
    func addTagFilter(tag: Tag) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
        update()
    }
    
    func clearAllLogs() {
        cleanLogs.insert(logs.map { $0.id })
        update()
    }
}
