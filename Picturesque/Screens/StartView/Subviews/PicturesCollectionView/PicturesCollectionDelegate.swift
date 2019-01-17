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
    func selected(picture: Picture)
    func deselected(picture: Picture)
}
