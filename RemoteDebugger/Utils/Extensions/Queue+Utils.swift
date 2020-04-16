//
//  Queue+Utils.swift
//  Antelope
//
//  Created by Daniel Huri on 1/18/19.
//  Copyright © 2019 Antelope. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static var currentLabel: String? {
        let queueLabelAddress = __dispatch_queue_get_label(nil)
        return String(validatingUTF8: queueLabelAddress)
    }
}

extension Thread {
    static var currentName: String? {
        return Thread.current.name
    }
}

extension OperationQueue {
    static var currentLabel: String? {
        return OperationQueue.current?.underlyingQueue?.label
    }
}
