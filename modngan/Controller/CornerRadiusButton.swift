//
//  CornerRadiusButton.swift
//  modngan
//
//  Created by CHAKRIT PANIAM on 11/19/17.
//  Copyright © 2017 Chakrit. All rights reserved.
//

import UIKit



@IBDesignable class CornerRadiusButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}

