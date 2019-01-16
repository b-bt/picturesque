//
//  PicturesCollectionDelegate.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

protocol PicturesCollectionDelegate {
    func scanNewPicture()
    func pictureSelected() // TODO: Add a picture argument
}
