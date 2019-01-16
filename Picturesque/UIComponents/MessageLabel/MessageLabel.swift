//
//  MessageLabel.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit


@IBDesignable class MessageLabel: UIView {

    fileprivate var contentView: UIView!
    fileprivate var shadowView: UIView!
    private var cornerRadius: CGFloat = 12.0
    
    @IBOutlet weak var label: UILabel!
    
    @IBInspectable var text: String? {
        didSet {
            self.label.text = self.text ?? ""
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
        self.backgroundColor = UIColor.clear
        
        self.clipsToBounds = false
        self.contentView = self.loadViewFromNib()
        self.addSubview(self.contentView)
        
        let heightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24)
        let centerXConstraint = NSLayoutConstraint(item: self.contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: self.contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([heightConstraint, centerXConstraint, centerYConstraint])
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.layer.cornerRadius = self.cornerRadius
        self.contentView.layer.masksToBounds = true
        
        self.createShadow()
        self.setNeedsLayout()
        self.bringSubviewToFront(self.contentView)
    }
    
    func createShadow() {
        self.shadowView = UIView()
        self.shadowView.addDropShadow(withRadius: 12)
        self.addSubview(self.shadowView)
        
        let heightConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([heightConstraint, centerXConstraint, centerYConstraint])
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
    }

}
