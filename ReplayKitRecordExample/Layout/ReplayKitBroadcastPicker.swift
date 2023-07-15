//
//  ReplayKitBroadcastPicker.swift
//  ReplayKitRecordExample
//
//  Created by p-x9 on 2023/07/15.
//  
//

import SwiftUI
import UIKit
import ReplayKit

struct ReplayKitBroadcastPicker: UIViewRepresentable {
    typealias UIViewType = RPSystemBroadcastPickerView

    func makeUIView(context: Context) -> RPSystemBroadcastPickerView {
        let broadcastPicker = RPSystemBroadcastPickerView(frame: .init(origin: .zero, size: .init(width: 100, height: 30)))

        broadcastPicker.preferredExtension = Constants.appGroupIdentifier
        if let button = broadcastPicker.subviews.compactMap({ $0 as? UIButton }).first {
            button.setImage(nil, for: .normal)
            button.setTitle("Record with broadcast", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
        }
        return broadcastPicker
    }

    func updateUIView(_ uiView: RPSystemBroadcastPickerView, context: Context) {}
}
