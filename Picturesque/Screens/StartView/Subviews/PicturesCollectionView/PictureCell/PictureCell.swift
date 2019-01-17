//
//  PictureCollectionViewCell.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    fileprivate var cellContentView: UIView!
    private let cornerRadius: CGFloat = 5.0
    
    @IBOutlet weak var imgView: UIImageView!
    
    var picture: Picture? {
        didSet {
            self.imgView.image = picture?.image
        }
    }
    
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
