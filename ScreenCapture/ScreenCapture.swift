//
//  ScreenCapture.swift
//  ScreenCapture
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation

public func captureRegion() -> NSURL {
    let tmpDir: String = NSTemporaryDirectory()
    
    let task = NSTask()
    task.launchPath = "/usr/sbin/screencapture"

    let name = imageName()
    let imgPath = "\(tmpDir)/\(name).png";
    
    task.arguments = ["-i", "-r", imgPath]
    task.launch()
    task.waitUntilExit()
    
    return NSURL(fileURLWithPath: imgPath)
}

public func captureScreen() -> NSURL {
    let tmpDir: String = NSTemporaryDirectory()
    let name = imageName()
    let imgPath = "\(tmpDir)/\(name).png"
    
    let img = CGDisplayCreateImage(CGMainDisplayID())
    let url = NSURL(fileURLWithPath: imgPath)
    let dest = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, nil)
    CGImageDestinationAddImage(dest!, img!, nil)
    CGImageDestinationFinalize(dest!)
    
    return url
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
    
    return "Screen Shot \(date).png"
}