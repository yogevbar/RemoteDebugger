//
//  LogsTestData.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 13/04/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Foundation

struct LogsTestData {
    
    static func createLogs() -> [Log] {
        let log  = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log1 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log2 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log3 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log4 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log5 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log6 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log7 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        let log8 = Log(id: "asasdasd", message: "test", level: .verbose, tags: [.cache, .network], function: "doSomething()", file: "SomeFile.swift", line: 1, thread: "", date: Date())
        return [log, log1, log2, log3, log4, log5, log6, log7, log8]
    }
    
    static func getLog() -> Log {
        return Log(
            id: "123e4567-e89b-12d3-a456-426655440000",
            message: "Test Log with 1 line of text",
            level: .verbose,
            tags: [.cache, .network],
            function: "doSomething()",
            file: "SomeFile.swift",
            line: 1,
            thread: "main",
            date: Date(),
            developerData: Data()
        )
    }
}
