//
//  ScreenCapture.swift
//  ScreenCapture
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation

// -------------------------------------------------------------------
// Allow passing of strings, just convert them to an NSURL.

public func captureRegion(_ destination: String) -> URL {
    return captureRegion(URL(fileURLWithPath: destination))
}

public func captureScreen(_ destination: String) -> URL {
    return captureScreen(URL(fileURLWithPath: destination))
}

public func recordScreen(_ destination: String) -> ScreenRecorder {
    return recordScreen(URL(fileURLWithPath: destination))
}

// -------------------------------------------------------------------

public func captureRegion(_ destination: URL) -> URL {
    let destinationPath = destination.path as String
    
    let task = Process()
    task.launchPath = "/usr/sbin/screencapture"
    task.arguments = ["-i", "-r", destinationPath]
    task.launch()
    task.waitUntilExit()
    
    return destination
}

public func captureScreen(_ destination: URL) -> URL {
    let img = CGDisplayCreateImage(CGMainDisplayID())
    let dest = CGImageDestinationCreateWithURL(destination as CFURL, kUTTypePNG, 1, nil)
    CGImageDestinationAddImage(dest!, img!, nil)
    CGImageDestinationFinalize(dest!)
    
    return destination
}

public func recordScreen(_ destination: URL) -> ScreenRecorder {
    return ScreenRecorder(destination: destination)
}
