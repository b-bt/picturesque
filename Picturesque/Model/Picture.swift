//
//  Picture.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class Picture {
    
    private(set) var image: UIImage
    let id: String
    
    init(withImage image: UIImage, id: String) {
        self.image = image
        self.id = id
    }
}
