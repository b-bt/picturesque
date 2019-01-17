//
//  LaserView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class LaserView: UIImageView {

    fileprivate static var horizontalOverflow: CGFloat = 30.0
        
    static func scan(view: UIView, completion: BlankCompletionBlock?=nil) {
        let laserImg = UIImage(named: "laser-scan")!
        let imageView = UIImageView(image: laserImg)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        view.addSubview(imageView)
        
        // Create constraints for laser view:
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: (-self.horizontalOverflow))
        view.addConstraints([heightConstraint, widthConstraint, centerXConstraint, topConstraint])
        view.setNeedsLayout()
        
        // Animate image opacity: make laser appear
        UIView.animate(withDuration: 0.5, animations: {
            imageView.alpha = 1.0
        })
        
        // Animate image constraint: move laser
        topConstraint.constant = view.frame.height + self.horizontalOverflow
        UIView.animate(withDuration: 2, delay: 0 , options: [.curveEaseInOut], animations: {
            view.layoutIfNeeded()
        }) { (_) in
            topConstraint.constant = -self.horizontalOverflow
            UIView.animate(withDuration: 2, delay: 0 , options: [.curveEaseInOut], animations: {
                view.layoutIfNeeded()
            }) { (_) in
                imageView.removeFromSuperview()
                completion?()
            }
        }
    }

}
