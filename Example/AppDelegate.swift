//
//  AppDelegate.swift
//  Example
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Cocoa
import ScreenCapture

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imgView: NSImageView!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func captureRegion(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureRegion().path!
        let img: NSImage = NSImage(contentsOfFile: imgPath)!
        imgView.image = img
    }
    
    @IBAction func captureScreen(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureScreen().path!
        let img: NSImage = NSImage(contentsOfFile: imgPath)!
        imgView.image = img
    }
}

