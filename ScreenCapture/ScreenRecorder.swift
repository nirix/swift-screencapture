//
//  ScreenRecorder.swift
//  ScreenCapture
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation
import AVFoundation

public class ScreenRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {
    var destination: String
    var session: AVCaptureSession?
    var movieFileOutput: AVCaptureMovieFileOutput?
    
    public var destinationUrl: NSURL {
        get {
            return NSURL(fileURLWithPath: self.destination)
        }
    }
    
    public init(destination: String) {
//        debugPrint("initialised ScreenRecorder with destination: \(destination)")
        
        self.destination = destination
        
        self.session = AVCaptureSession()
        self.session?.sessionPreset = AVCaptureSessionPresetHigh
        
        let displayId: CGDirectDisplayID = CGDirectDisplayID(CGMainDisplayID())

        let input: AVCaptureScreenInput = AVCaptureScreenInput(displayID: displayId)
        
        if (input == false) {
            self.session = nil
            return
        }
        
        if ((self.session?.canAddInput(input)) != nil) {
            self.session?.addInput(input)
        }
        
        self.movieFileOutput = AVCaptureMovieFileOutput()

        
        if ((self.session?.canAddOutput(self.movieFileOutput)) != nil) {
            self.session?.addOutput(self.movieFileOutput)
        }
        
//        if ((self.movieFileOutput?.connections.first) != nil) {
//            let conn: AVCaptureConnection = self.movieFileOutput?.connections.first as! AVCaptureConnection
//            if (conn.supportsVideoMinFrameDuration) {
//                debugPrint("Setting min frame duration")
//                conn.videoMinFrameDuration = CMTime(value: 1, timescale: 60)
//            }
//            
//            if (conn.supportsVideoMaxFrameDuration) {
//                debugPrint("Setting max frame duration")
//                conn.videoMaxFrameDuration = kCMTimeZero
//                conn.videoMaxFrameDuration = CMTime(value: 1, timescale: 60)
//            }
//        }
    }
 
    public func start() {
//        debugPrint("Started recording to file: \(self.destination)")
        self.session?.startRunning()
        self.movieFileOutput?.startRecordingToOutputFileURL(self.destinationUrl, recordingDelegate: self)
    }
    
    public func stop() {
//        debugPrint("Stopping recording to file: \(self.destination)")
        self.movieFileOutput?.stopRecording()
    }
    
    public func captureOutput(
        captureOutput: AVCaptureFileOutput!,
        didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!,
        fromConnections connections: [AnyObject]!,
        error: NSError!
    ) {
        self.session?.stopRunning()
        self.session = nil
    }
}