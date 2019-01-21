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
        stopRecordingBtn.isEnabled = false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        do {
            if (FileManager.default.fileExists(atPath: "\(self.tmpDir)captureRegion.png")) {
                try FileManager.default.removeItem(atPath: "\(self.tmpDir)captureRegion.png")
            }
            
            if (FileManager.default.fileExists(atPath: "\(self.tmpDir)captureScreen.png")) {
                try FileManager.default.removeItem(atPath: "\(self.tmpDir)captureScreen.png")
            }
            
            if (FileManager.default.fileExists(atPath: "\(self.tmpDir)screenRecording.mp4")) {
                try FileManager.default.removeItem(atPath: "\(self.tmpDir)screenRecording.mp4")
            }
        } catch {}
    }
    
    @IBAction func captureRegion(sender: NSButton) {
        let imgPath: String = ScreenCapture.captureRegion("\(self.tmpDir)captureRegion.png").path
        
        if (FileManager.default.fileExists(atPath: imgPath)) {
            let img: NSImage = NSImage(contentsOfFile: imgPath)!
            imgView.image = img
        }
    }
    
    @IBAction func captureScreen(sender: NSButton) {
        window.performMiniaturize(sender)
        let imgPath: String = ScreenCapture.captureScreen("\(self.tmpDir)captureScreen.png").path
        let img: NSImage = NSImage(contentsOfFile: imgPath)!
        imgView.image = img
    }
    
    @IBAction func startRecording(sender: NSButton) {
        do {
            if (FileManager.default.fileExists(atPath: "\(self.tmpDir)screenRecording.mp4")) {
                try FileManager.default.removeItem(atPath: "\(self.tmpDir)screenRecording.mp4")
            }
        } catch {}
        
        startRecordingBtn.isEnabled = false
        stopRecordingBtn.isEnabled = true
        screenRecorder = ScreenCapture.recordScreen("\(self.tmpDir)screenRecording.mp4")
        screenRecorder!.start()
    }
    
    @IBAction func stopRecording(sender: NSButton) {
        screenRecorder!.stop()
        
        startRecordingBtn.isEnabled = true
        stopRecordingBtn.isEnabled = false
        
        debugPrint(screenRecorder!.destination)
    }
    
    
    // It's better to seperate the playback function cause the stopRunning / writing video process may take some time
    @IBAction func playback(_ sender: NSButton) {
        
        self.player = AVPlayer(url: screenRecorder!.destination)
        self.playerView.player = self.player
        self.playerView.player?.play()
    }
}

