//
//  CameraViewProtocol.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

protocol CameraViewProtocol {
    func startCamera()
    func add(picture: Picture)
    func remove(picture: Picture)
}
