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
    
    private func select(view: PictureView?) {
        for (_, pictureView) in self.pictureViews {
            if pictureView == view {
                pictureView.isSelected = true
            } else {
                pictureView.isSelected = false
            }
        }
    }
    
    // MARK: Gesture Recognizers creation methods:
    private func addPanRecognizer(to view: PictureView) {
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([centerXConstraint, centerYConstraint])
        self.pictureCenterConstraints[view.picture!.id] = (x: centerXConstraint, y: centerYConstraint)
        self.setNeedsLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    private func addPinchRegognizer(to view: PictureView) {
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchView(_:)))
        view.addGestureRecognizer(pinchRecognizer)
    }
    
    private func addRotationGesture(to view: PictureView) {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateView(_:)))
        view.addGestureRecognizer(rotationGesture)
    }
    
    // MARK: Gesture Recognizers Responders:
    @objc private func mainViewTapped(_ sender: UITapGestureRecognizer) {
        self.select(view: nil)
    }
    
    @objc private func tapView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? PictureView else { return }
        if view.isSelected {
            view.isSelected = false
        } else {
            self.select(view: view)
        }
    }
    
    @objc private func dragView(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view as? PictureView,
            let pictureId = view.picture?.id,
            let (centerXConstraint, centerYConstraint) = self.pictureCenterConstraints[pictureId]
        else { return }
        
        self.select(view: view)
        self.bringSubviewToFront(view)
        
        let translation = sender.translation(in: self)
        let centerX = centerXConstraint.constant + translation.x
        let centerY = centerYConstraint.constant + translation.y
        centerXConstraint.constant = centerX
        centerYConstraint.constant = centerY
        self.setNeedsLayout()
        sender.setTranslation(CGPoint.zero, in: self)
    }

    @objc private func pinchView(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view as? PictureView else { return }
        print(sender.scale)
        view.scale(by: sender.scale)
        sender.scale = 1.0
    }
    
    @objc private func rotateView(_ sender: UIRotationGestureRecognizer) {
        guard let view = sender.view as? PictureView else { return }
        
        view.transform = view.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
}

extension MockCameraView: CameraViewProtocol {
    func startCamera() {
        self.roundCorners(corners: .allCorners, radius: 5.0)
        self.clipsToBounds = true
        
        self.addBgImage()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    func add(picture: Picture) {
        let pictureView = PictureView(frame: CGRect(x: center.x, y: center.y, width: 100, height: 100))
        pictureView.picture = picture
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        self.pictureViews[picture.id] = pictureView
        self.addSubview(pictureView)
        
        // Add recognizers and their needed constraints:
        pictureView.isUserInteractionEnabled = true
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        pictureView.addGestureRecognizer(tapGesture)
        self.addPanRecognizer(to: pictureView)
        self.addPinchRegognizer(to: pictureView)
        self.addRotationGesture(to: pictureView)
        
        self.select(view: pictureView)
    }
    
    func remove(picture: Picture) {
        guard let pictureView = self.pictureViews[picture.id] else { return }
        pictureView.removeFromSuperview()
    }
}
