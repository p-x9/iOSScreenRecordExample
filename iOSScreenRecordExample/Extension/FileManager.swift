//
//  FileManager.swift
//  iOSScreenRecordExample
//
//  Created by p-x9 on 2023/07/15.
//
//

import Foundation

extension FileManager {
    func removeItemIfExisted(at URL: URL) throws {
        guard self.fileExists(atPath: URL.path) else {
            return
        }

        try self.removeItem(at: URL)
    }
}

