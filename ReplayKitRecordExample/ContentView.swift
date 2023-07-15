//
//  ContentView.swift
//  ReplayKitRecordExample
//
//  Created by p-x9 on 2023/07/15.
//  
//

import SwiftUI
import ReplayKit
import UIKit
import AVKit

struct ContentView: View {
    var outputURL: URL {
        let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: Constants.appGroupIdentifier
        )!
        return containerURL.appending(components: "output.mp4")
    }

    var tmpURL: URL {
        let tmp = FileManager.default.temporaryDirectory
        return tmp.appending(components: "output.mp4")
    }

    let fileManager: FileManager = .default
    let screenRecorder: RPScreenRecorder = .shared()

    @State var isRecording = false
    @State var showPlayer = false

    var body: some View {
        VStack {
            Spacer()

            Button {
                if screenRecorder.isRecording {
                    try? fileManager.removeItemIfExisted(at: tmpURL)
                    screenRecorder.stopRecording(withOutput: tmpURL) { _ in
                        isRecording = false
                        try? fileManager.removeItemIfExisted(at: outputURL)
                        try? fileManager.moveItem(at: tmpURL, to: outputURL)
                    }
                } else {
                    screenRecorder.startRecording { _ in
                        isRecording = true
                    }
                }

            } label: {
                Text("Record with ScreenRecorder") +
                Text(isRecording ? "(Recording)" : "")
            }

            ReplayKitBroadcastPicker()
                .frame(maxWidth: .infinity)
                .frame(height: 30)

            Spacer()

            Divider()

            Button {
                if fileManager.fileExists(atPath: outputURL.path) {
                    showPlayer = true
                }

            } label: {
                Text("Show recorded movie if exited")
            }
        }
        .padding()
        .sheet(isPresented: $showPlayer) {
            VideoPreview(player: AVPlayer(url: outputURL))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
