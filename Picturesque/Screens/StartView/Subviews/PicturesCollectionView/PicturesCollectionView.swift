//
//  PicturesCollectionView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PicturesCollectionView: UICollectionView {

    private let pictureCellIdentifier = "pictureCell"
    private let newPictureCellIdentifier = "newPictureCellIdentifier"
    
    var picturesDelegate: PicturesCollectionDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.dataSource = self
        self.delegate = self
        
        // Register cells:
        self.register(PictureCell.self, forCellWithReuseIdentifier: self.pictureCellIdentifier)
        self.register(NewPictureCell.self, forCellWithReuseIdentifier: self.newPictureCellIdentifier)
    }
    
    func reloadPictures() {
        // TODO: animate picture additions
        self.reloadData()
    }

}

extension PicturesCollectionView: UICollectionViewDataSource {
    // TODO: display message if empty
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PicturesManager.picturesCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.item == 0) { // Initial cell should be a new
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.newPictureCellIdentifier, for: indexPath)
            return cell
        }
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.pictureCellIdentifier, for: indexPath) as! PictureCell
        if let picture = PicturesManager.picture(at: (indexPath.item-1)) {
            cell.picture = picture
        }
        return cell
    }
}

extension PicturesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.picturesDelegate?.scanNewPicture()
            return
        }
        
        // TODO: select picture and send it to CameraView
    }
}
