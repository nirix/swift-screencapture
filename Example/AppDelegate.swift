//
//  AppDelegate.swift
//  Example
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation
import ScreenCapture

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var playerView: AVPlayerView!
    @IBOutlet weak var startRecordingBtn: NSButton!
    @IBOutlet weak var stopRecordingBtn: NSButton!
    
    var player: AVPlayer?
    
    var screenRecorder: ScreenCapture.ScreenRecorder?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        stopRecordingBtn.enabled = false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func captureRegion(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureRegion().path!
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath)) {
            let img: NSImage = NSImage(contentsOfFile: imgPath)!
            imgView.image = img
        }
    }
    
    @IBAction func captureScreen(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureScreen().path!
        let img: NSImage = NSImage(contentsOfFile: imgPath)!
        imgView.image = img
    }
    
    @IBAction func startRecording(sender: NSButton) {
        let tmpDir: String = NSTemporaryDirectory()
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath("\(tmpDir)test.mp4")
        } catch {}
        
        startRecordingBtn.enabled = false
        stopRecordingBtn.enabled = true
        screenRecorder = ScreenCapture.recordScreen("\(tmpDir)test.mp4")
        screenRecorder!.start()
    }
    
    @IBAction func stopRecording(sender: NSButton) {
        screenRecorder!.stop()
        
        startRecordingBtn.enabled = true
        stopRecordingBtn.enabled = false
        
        debugPrint(screenRecorder!.destinationUrl)
        self.player = AVPlayer(URL: screenRecorder!.destinationUrl)
        self.playerView.player = self.player
        self.playerView.player?.play()
    }
}

