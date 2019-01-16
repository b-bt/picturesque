//
//  UIView+Xib.swift
//  Picturesque
//
//  Created by Bruno Barbosa on 16/01/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib() -> UIView! {
        let nibName: String = String(describing: type(of: self))
        
        let bundle: Bundle = Bundle(for: type(of: self))
        let nib: UINib = UINib(nibName: nibName, bundle: bundle)
        let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }
}
