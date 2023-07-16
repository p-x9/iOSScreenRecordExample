# iOSScreenRecordExample
Collection of screen recording methods on iOS

## Table of Contents
- [iOSScreenRecordExample](#iosscreenrecordexample)
  - [Table of Contents](#table-of-contents)
  - [Build \& Install on real devices](#build--install-on-real-devices)
  - [About methods of screen recording in iOS](#about-methods-of-screen-recording-in-ios)
    - [1. Use `render(in ctx: CGContext)` of CALayer](#1-use-renderin-ctx-cgcontext-of-calayer)
    - [2. Use `RPScreenRecorder`](#2-use-rpscreenrecorder)
    - [3. Use Broadcast extension](#3-use-broadcast-extension)
  - [License](#license)

## Build & Install on real devices
Because of the ReplayKit, some functions will not work in the simulator.
When installing on an actual device, it is necessary to change the Bundle Id and App Group ID from the Signing setting in Xcode.
Also, please change the ID listed in the following file to the same ID you set in Xcode.
[Constants.swift](./iOSScreenRecordExample/Constants.swift)

## About methods of screen recording in iOS
There are several ways to perform screen recording on iOS devices.
An overview of each method and its features are listed below.

### 1. Use `render(in ctx: CGContext)` of CALayer
Use CALayer's `render(in ctx: CGContext)` method to obtain a CVPixelBuffer. Screen recording can be performed by periodically doing this while outputting as a video file.
Unlike other methods, this method allows recording only for a specific widnow or windowScene.
On the other hand, the load is higher than other methods because of the high frequency of drawing.
If you want to record the entire screen, it is better to use the method described below.

[p-x9/ScreenCapture](https://github.com/p-x9/ScreenCapture)

### 2. Use `RPScreenRecorder`
ReplayKit provides a class for screen recording.
In many cases, this is a good method to use.

### 3. Use Broadcast extension
App extension used for normal screen broadcasts.
Unlike other methods, this method also allows recording of screens outside the application.

<img src="https://github.com/p-x9/iOSScreenRecordExample/assets/50244599/94c1cda5-698a-4644-8121-2f7f3a55989a" width="375"/>

## License

iOSScreenRecordExample is released under the MIT License. See [LICENSE](./LICENSE)
