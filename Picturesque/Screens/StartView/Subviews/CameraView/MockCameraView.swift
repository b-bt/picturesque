//
//  MockCameraView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MockCameraView: UIView, CameraViewProtocol {
    
    func startCamera() {
        self.roundCorners(corners: .allCorners, radius: 5.0)
        self.clipsToBounds = true
        
       self.addImage()
    }
    
    private func addImage() {
        guard let wallImage:UIImage = UIImage(named: "wall-image") else {
            return
        }
        let imageView = UIImageView(image: wallImage)
        imageView.frame = self.frame
        imageView.center = self.center
        self.addSubview(imageView)
        
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([heightConstraint, widthConstraint, centerXConstraint, centerYConstraint])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.setNeedsLayout()
    }

}
