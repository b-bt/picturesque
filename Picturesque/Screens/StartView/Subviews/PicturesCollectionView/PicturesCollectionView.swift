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
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.commonInit()
        
        print("INIT frame layout")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        
        print("INIT coder")
    }
    
    func commonInit() {
        self.dataSource = self
        
        // Register cells:
        self.register(PictureCell.self, forCellWithReuseIdentifier: self.pictureCellIdentifier)
        self.register(NewPictureCell.self, forCellWithReuseIdentifier: self.newPictureCellIdentifier)
    }

}

extension PicturesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.item == 0) { // Initial cell should be a new 
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.newPictureCellIdentifier, for: indexPath)
            return cell
        }
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.pictureCellIdentifier, for: indexPath) as! PictureCell
        return cell
    }
    
    
}
