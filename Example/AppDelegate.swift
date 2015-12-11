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
    
    let tmpDir: String = NSTemporaryDirectory()
    var player: AVPlayer?
    
    var screenRecorder: ScreenCapture.ScreenRecorder?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        stopRecordingBtn.enabled = false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func captureRegion(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureRegion("\(self.tmpDir)captureRegion.png").path!
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath)) {
            let img: NSImage = NSImage(contentsOfFile: imgPath)!
            imgView.image = img
        }
    }
    
    @IBAction func captureScreen(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureScreen("\(self.tmpDir)captureScreen.png").path!
        let img: NSImage = NSImage(contentsOfFile: imgPath)!
        imgView.image = img
    }
    
    @IBAction func startRecording(sender: NSButton) {
        do {
            if (NSFileManager.defaultManager().fileExistsAtPath("\(self.tmpDir)screenRecording.mp4")) {
                try NSFileManager.defaultManager().removeItemAtPath("\(self.tmpDir)screenRecording.mp4")
            }
        } catch {}
        
        startRecordingBtn.enabled = false
        stopRecordingBtn.enabled = true
        screenRecorder = ScreenCapture.recordScreen("\(self.tmpDir)screenRecording.mp4")
        screenRecorder!.start()
    }
    
    @IBAction func stopRecording(sender: NSButton) {
        screenRecorder!.stop()
        
        startRecordingBtn.enabled = true
        stopRecordingBtn.enabled = false
        
        debugPrint(screenRecorder!.destination)
        self.player = AVPlayer(URL: screenRecorder!.destination)
        self.playerView.player = self.player
        self.playerView.player?.play()
    }
}

