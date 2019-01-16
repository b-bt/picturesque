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
        self.register(PictureCell.self, forCellWithReuseIdentifier: self.pictureCellIdentifier)
    }

}

extension PicturesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.pictureCellIdentifier, for: indexPath) as! PictureCell
        return cell
    }
    
    
}
