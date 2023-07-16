//
//  SampleHandler.swift
//  iOSScreenRecordExample
//
//  Created by p-x9 on 2023/07/15.
//
//

import ReplayKit
import MovieWriter

class SampleHandler: RPBroadcastSampleHandler {

    var outputURL: URL {
        let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.p-x9.Example"
        )!
        return containerURL.appending(components: "output.mp4")
    }

    var tmpURL: URL {
        let tmp = FileManager.default.temporaryDirectory
        return tmp.appending(components: "output.mp4")
    }

    var movieWriter: MovieWriter!

    let fileManager = FileManager.default

    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        do {
            try fileManager.removeItemIfExisted(at: tmpURL)
            movieWriter = .init(outputUrl: tmpURL, size: UIScreen.main.bounds.size)
            movieWriter.isAudioEnabled = true
            movieWriter.isMicrophoneEnabled = true
            try movieWriter.start(waitFirstWriting: true)
        } catch {
            print(error)
        }
    }


    override func broadcastFinished() {
        do {
            guard let movieWriter else { return }
            try movieWriter.end(at: movieWriter.state.lastFrameTime,
                                waitUntilFinish: true)
            try fileManager.removeItemIfExisted(at: outputURL)
            try fileManager.moveItem(at: tmpURL, to: outputURL)
        } catch {
            print(error)
        }
    }

    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        guard let movieWriter else { return }

        do {
            switch sampleBufferType {
            case RPSampleBufferType.video:
                try movieWriter.writeFrame(sampleBuffer)
            case RPSampleBufferType.audioApp:
                try movieWriter.writeAudio(sampleBuffer)
            case RPSampleBufferType.audioMic:
                try movieWriter.writeMic(sampleBuffer)
            @unknown default:
                // Handle other sample buffer types
                fatalError("Unknown type of sample buffer")
            }
        } catch {
            print(error, sampleBufferType)
        }
    }
}

extension FileManager {
    func removeItemIfExisted(at URL: URL) throws {
        guard self.fileExists(atPath: URL.path) else {
            return
        }

        try self.removeItem(at: URL)
    }
}
