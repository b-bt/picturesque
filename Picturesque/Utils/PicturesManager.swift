//
//  PicturesManager.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PicturesManager {
    private init() {
        self.scanNewPicture()
        self.scanNewPicture()
    }
    static private(set) var shared: PicturesManager = PicturesManager()
    
    private(set) var scannedPictures: [Picture] = []
    // Mocked pictures data:
    private var currentId: Int = 0
    private var pendingImages: [UIImage] =
        [
            UIImage(named: "pic-pink")!,
            UIImage(named: "pic-monster")!,
            UIImage(named: "pic-steven")!,
            UIImage(named: "pic-titans")!,
            UIImage(named: "pic-gravity")!
        ]
    
    // TODO: Replace this method for one that receives a new picture
    private func scanNewPicture() {
        guard let image = self.pendingImages.popLast() else {
            return
        }
        
        let picture = Picture(withImage: image, id: "picture\(currentId)")
        self.currentId += 1
        self.scannedPictures.append(picture)
    }
    
    // MARK: Static methods and properties
    static var picturesCount: Int {
        return PicturesManager.shared.scannedPictures.count
    }
    
    static func scanNewPicture() {
        PicturesManager.shared.scanNewPicture()
    }
    
    static func picture(at position: Int) -> Picture? {
        return PicturesManager.shared.scannedPictures[position]
    }
}
