//
//  PictureCollectionViewCell.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    fileprivate var picContentView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.addDropShadow(withRadius: 5)
        self.backgroundColor = UIColor.clear
        
        self.picContentView = self.loadViewFromNib()
        self.picContentView.roundCorners(corners: .allCorners, radius: 5)
        self.addSubview(self.picContentView)
    }
}
