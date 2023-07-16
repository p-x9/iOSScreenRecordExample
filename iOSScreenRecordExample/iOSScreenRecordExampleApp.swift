//
//  iOSScreenRecordExampleApp.swift
//  iOSScreenRecordExample
//
//  Created by p-x9 on 2023/07/15.
//
//

import SwiftUI
import TouchTracker

@main
struct iOSScreenRecordExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .touchTrack()
        }
    }
}
