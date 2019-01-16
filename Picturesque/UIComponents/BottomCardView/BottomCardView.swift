//
//  BottomCardView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

@IBDesignable class BottomCardView: UIView {

    @IBInspectable var contentBgColor: UIColor? {
        didSet {
            self.contentView.backgroundColor = self.contentBgColor
        }
    }
    
    fileprivate var contentView: UIView!
    
    private let cornersRadius: CGFloat = 10.0;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        self.addDropShadow()
        
        self.contentView = UIView(frame: self.frame)
        self.contentView.center = self.center
        self.contentView.backgroundColor = self.contentBgColor
        self.addSubview(self.contentView!)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: self.contentView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: self.contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: self.contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([heightConstraint, widthConstraint, centerXConstraint, centerYConstraint])
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sendSubviewToBack(self.contentView)
        self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: self.cornersRadius)
    }

}
