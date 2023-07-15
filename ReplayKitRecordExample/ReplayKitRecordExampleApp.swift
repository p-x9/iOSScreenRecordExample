//
//  ReplayKitRecordExampleApp.swift
//  ReplayKitRecordExample
//
//  Created by p-x9 on 2023/07/15.
//  
//

import SwiftUI
import TouchTracker

@main
struct ReplayKitRecordExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .touchTrack()
        }
    }
}
