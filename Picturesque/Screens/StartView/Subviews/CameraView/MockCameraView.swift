//
//  MockCameraView.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MockCameraView: UIView {
    
    private var pictureViews: [String:PictureView] = [:]
    private var pictureCenterConstraints: [String : (x: NSLayoutConstraint, y: NSLayoutConstraint)] = [:]
    
    private func addBgImage() {
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
    
    private func addPanRecognizer(to view: PictureView) {
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([centerXConstraint, centerYConstraint])
        self.pictureCenterConstraints[view.picture!.id] = (x: centerXConstraint, y: centerYConstraint)
        self.setNeedsLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Gesture Recognizers Responders:
    @objc private func dragView(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view as? PictureView,
            let pictureId = view.picture?.id,
            let (centerXConstraint, centerYConstraint) = self.pictureCenterConstraints[pictureId]
        else { return }
        
        self.bringSubviewToFront(view)
        
        let translation = sender.translation(in: self)
        let centerX = centerXConstraint.constant + translation.x
        let centerY = centerYConstraint.constant + translation.y
        centerXConstraint.constant = centerX
        centerYConstraint.constant = centerY
        self.setNeedsLayout()
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
    

}

extension MockCameraView: CameraViewProtocol {
    func startCamera() {
        self.roundCorners(corners: .allCorners, radius: 5.0)
        self.clipsToBounds = true
        
        self.addBgImage()
    }
    
    func add(picture: Picture) {
        let pictureView = PictureView(frame: CGRect(x: center.x, y: center.y, width: 100, height: 100))
        pictureView.picture = picture
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        self.pictureViews[picture.id] = pictureView
        self.addSubview(pictureView)
        
        // Add recognizers and their needed constraints:
        self.addPanRecognizer(to: pictureView)
    }
    
    func remove(picture: Picture) {
        guard let pictureView = self.pictureViews[picture.id] else { return }
        pictureView.removeFromSuperview()
    }
}
