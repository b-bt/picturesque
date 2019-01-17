//
//  StartView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    @IBOutlet weak var cameraView: MockCameraView!
    @IBOutlet weak var picturesCollection: PicturesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cameraView.startCamera()
        self.picturesCollection.picturesDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.picturesCollection.reloadPictures()
    }
}

extension StartView: PicturesCollectionDelegate {
    func scanNewPicture() {
        self.performSegue(withIdentifier: "scanPictureSegue", sender: nil)
    }
    
    func selected(picture: Picture) {
        
    }
    
    func deselected(picture: Picture) {
        
    }
}
