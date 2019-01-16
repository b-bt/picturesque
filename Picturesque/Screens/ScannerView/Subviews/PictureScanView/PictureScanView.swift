//
//  PictureScanView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit
import AVFoundation

class PictureScanView: UIView {
    
    // MARK: Camera Properties
    private var captureCameraSession = AVCaptureSession()
    private lazy var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureCameraSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let videoDataOutputQueue = DispatchQueue(label: "ARVideoDataOutput",
                                                     qos: .userInitiated,
                                                     attributes: [], autoreleaseFrequency: .workItem)
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.setupAVCapture(session: captureCameraSession,
                            cameraLayer: cameraLayer,
                            videoDataOutput: videoDataOutput,
                            videoDataOutputQueue: videoDataOutputQueue,
                            outputDelegate: self)
        self.startCapturing(captureCameraSession)
    }

}

extension PictureScanView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}
