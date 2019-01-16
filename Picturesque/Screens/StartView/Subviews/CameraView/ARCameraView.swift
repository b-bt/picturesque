//
//  CameraView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable
class ARCameraView: UIView {

    // MARK: Camera Properties and Functions
    private var captureCameraSession = AVCaptureSession()
    private lazy var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureCameraSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let videoDataOutputQueue = DispatchQueue(label: "ARVideoDataOutput",
                                                     qos: .userInitiated,
                                                     attributes: [], autoreleaseFrequency: .workItem)

    func startCamera() {
        self.setupAVCapture(session: captureCameraSession,
                            cameraLayer: cameraLayer,
                            videoDataOutput: videoDataOutput,
                            videoDataOutputQueue: videoDataOutputQueue,
                            outputDelegate: self)
        self.startCapturing(self.captureCameraSession)
    }
    
    // Initializer:
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.lightGray
        self.roundCorners(corners: [.allCorners], radius: 5.0)
    }
}

extension ARCameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            return
//        }
        
        // TODO: do something with the image
    }
}

