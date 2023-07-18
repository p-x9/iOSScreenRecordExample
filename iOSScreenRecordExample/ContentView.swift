//
//  ContentView.swift
//  iOSScreenRecordExample
//
//  Created by p-x9 on 2023/07/15.
//
//

import SwiftUI
import ReplayKit
import UIKit
import AVKit
import ScreenCapture

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
    var screenCapture: ScreenCapture? {
        sceneDelegate.screenCapture
    }

    @EnvironmentObject var sceneDelegate: SceneDelegate
    @State var isRecordingWithRP = false
    @State var isRecordingWithSC = false
    @State var showPlayer = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Button {
                guard let screenCapture else { return }
                if screenCapture.isRunning {
                    try? screenCapture.end()
                    isRecordingWithSC = false
                    try? fileManager.removeItemIfExisted(at: outputURL)
                    try? fileManager.moveItem(at: tmpURL, to: outputURL)
                } else {
                    try? fileManager.removeItemIfExisted(at: tmpURL)
                    try? screenCapture.start(outputURL: tmpURL)
                    isRecordingWithSC = true
                }
            } label: {
                Text(isRecordingWithSC ? "(Recording) " : "")
                    .foregroundColor(.red)
                +
                Text("Record with `render(in ctx: CGContext)`")
            }

            Button {
                if screenRecorder.isRecording {
                    try? fileManager.removeItemIfExisted(at: tmpURL)
                    screenRecorder.stopRecording(withOutput: tmpURL) { _ in
                        isRecordingWithRP = false
                        try? fileManager.removeItemIfExisted(at: outputURL)
                        try? fileManager.moveItem(at: tmpURL, to: outputURL)
                    }
                } else {
                    screenRecorder.startRecording { _ in
                        isRecordingWithRP = true
                    }
                }

            } label: {
                Text(isRecordingWithSC ? "(Recording) " : "")
                    .foregroundColor(.red)
                +
                Text("Record with RPScreenRecorder")
            }

            ReplayKitBroadcastPicker()
                .frame(maxWidth: .infinity)
                .frame(height: 17)

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
