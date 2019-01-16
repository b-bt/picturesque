//
//  NewPictureCell.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class NewPictureCell: UICollectionViewCell {
    
    fileprivate var cellContentView: UIView!
    private var cornerRadius: CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.addDropShadow(withRadius: self.cornerRadius)
        self.backgroundColor = UIColor.clear
        
        self.cellContentView = self.loadViewFromNib()
        self.cellContentView.roundCorners(corners: .allCorners, radius: self.cornerRadius)
        self.addSubview(self.cellContentView)
    }
}
