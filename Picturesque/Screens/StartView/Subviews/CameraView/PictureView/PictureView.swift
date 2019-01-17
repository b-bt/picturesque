//
//  PictureView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 17/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PictureView: UIView {

    fileprivate var contentView: UIView!
    private var aspectRatioConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var moveIcon: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    
    var picture: Picture? {
        didSet {
            guard let pic = self.picture else { return }
            self.imageView.image = pic.image
            
            let ratio = pic.image.size.height / pic.image.size.width
            self.set(height: 110, andRatio: ratio)
        }
    }
    
    var isSelected: Bool = true {
        didSet {
            self.moveIcon.isHidden = !isSelected
            self.closeBtn.isHidden = !isSelected
            
            if isSelected {
                self.addDropShadow(withRadius: 5, andOffset: CGSize(width: 0, height: 2))
                // Add border
                self.layer.borderColor = UIColor.white.cgColor
                self.layer.borderWidth = 3
            } else {
                self.layer.shadowOpacity = 0
                self.layer.borderWidth = 0
            }
        }
    }
    
    /*init(with picture: Picture) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.commonInit()
        self.picture = picture
    }*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.contentView = self.loadViewFromNib()
        self.addSubview(self.contentView)
        
        let topConstraint = NSLayoutConstraint(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.setNeedsLayout()
        
        self.isSelected = true
    }
    
    func set(height: CGFloat, andRatio ratio: CGFloat) {
        if let ratioConstraint = self.aspectRatioConstraint, let heightConstraint = self.heightConstraint {
            NSLayoutConstraint.deactivate([ratioConstraint, heightConstraint])
        }
        self.aspectRatioConstraint = NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .width,
                           multiplier: ratio,
                           constant: 0)
        self.heightConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)
        self.addConstraints([self.aspectRatioConstraint!, self.heightConstraint!])
        UIView.animate(withDuration: 1) {
            self.setNeedsLayout()
        }
    }

}
