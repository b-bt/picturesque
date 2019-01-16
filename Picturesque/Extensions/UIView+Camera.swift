//
//  UIView+Camera.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView {
    func setupAVCapture(session: AVCaptureSession,
                        cameraLayer: AVCaptureVideoPreviewLayer,
                        videoDataOutput: AVCaptureVideoDataOutput,
                        videoDataOutputQueue: DispatchQueue,
                        outputDelegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        guard session.canAddInput(deviceInput) else {
            session.commitConfiguration()
            return
        }
        
        session.addInput(deviceInput)
        
        guard session.canAddOutput(videoDataOutput) else {
            print("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        
        session.addOutput(videoDataOutput)
        
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        videoDataOutput.setSampleBufferDelegate(outputDelegate, queue: videoDataOutputQueue)
        
        session.commitConfiguration()
        
        cameraLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraLayer.frame = self.layer.bounds
        self.layer.addSublayer(cameraLayer)
    }
    
    func startCapturing(_ session: AVCaptureSession) {
        session.startRunning()
    }
}
