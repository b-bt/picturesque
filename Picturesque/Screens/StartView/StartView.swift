//
//  StartView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    @IBOutlet weak var cameraView: ARCameraView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cameraView.startCamera()
    }
}
