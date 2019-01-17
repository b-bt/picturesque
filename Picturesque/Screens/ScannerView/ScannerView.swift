//
//  ScanView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class ScannerView: UIViewController {

    @IBOutlet weak var messageLbl: MessageLabel!
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var secondaryBtn: LabelButton!
    
    private var isScanning: Bool = false {
        didSet {
            self.photoBtn.isEnabled = !self.isScanning
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func scanPictureTapped(_ sender: Any) {
        if isScanning {
            return
        }
        self.isScanning = true
        
        LaserView.scan(view: self.view, completion: {
            self.isScanning = false
        })
    }
    
}
