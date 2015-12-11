//
//  ScreenCapture.swift
//  ScreenCapture
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation

    
    let task = NSTask()
    task.launchPath = "/usr/sbin/screencapture"
    task.arguments = ["-i", "-r", destinationPath]
    task.launch()
    task.waitUntilExit()
    
    return destination
}

public func captureScreen(destination: NSURL) -> NSURL {
    let img = CGDisplayCreateImage(CGMainDisplayID())
    let dest = CGImageDestinationCreateWithURL(destination, kUTTypePNG, 1, nil)
    CGImageDestinationAddImage(dest!, img!, nil)
    CGImageDestinationFinalize(dest!)
    
    return destination
}

public func recordScreen(destination: String) -> ScreenRecorder {
    return ScreenRecorder(destination: destination)
}

func imageName() -> String {
    // Just going to use this for now
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .MediumStyle
    dateFormatter.dateStyle = .ShortStyle
    
    let date = dateFormatter.stringFromDate(NSDate())
        .stringByReplacingOccurrencesOfString("/", withString: "-")
        .stringByReplacingOccurrencesOfString(":", withString: ".")
        .stringByReplacingOccurrencesOfString(",", withString: "")
    
    return "Screen Shot \(date)"
}