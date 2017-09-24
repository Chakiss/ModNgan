//
//  MeridianButton.swift
//  dtac-iservice
//
//  Created by Chakrit on 8/1/2560 BE.
//  Copyright © 2560 TOTAL ACCESS COMMUNICATION PUBLIC COMPANY LIMITED. All rights reserved.
//

import UIKit

enum RadiusButtonStyle {
    case Blue
    case Red
    case Yellow
}


class RadiusButton: UIControl {
    
    var radiusButtonStyle: RadiusButtonStyle = .Blue
    var cornerRadius: CGFloat = 16.0

    var textLabel: UILabel = UILabel()
    var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    var title: NSString = ""

    var style: RadiusButtonStyle = RadiusButtonStyle.Blue

    
    
    init(frame: CGRect, style: RadiusButtonStyle) {
        self.textLabel = UILabel()
        self.radiusButtonStyle = style
        
        super.init(frame: frame)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override func awakeFromNib() {
        
        self.textLabel = UILabel(frame: CGRect.zero)
        self.textLabel.backgroundColor = UIColor.clear
        self.textLabel.textAlignment = NSTextAlignment.center
        self.textLabel.textColor = UIColor.white
        self.textLabel.adjustsFontSizeToFitWidth = true
        self.textLabel.minimumScaleFactor = 0.1
        self.textLabel.numberOfLines = 1
        self.textLabel.font = UIFont(name: "DTAC2013-Regular", size: 13.0)
        self.textLabel.sizeToFit()
        
        self.addSubview(self.textLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.drawTextLabel()
        self.textLabel.text = self.title as String
        self.layer.cornerRadius = self.cornerRadius
        
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 14.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.layer.shadowPath = path.cgPath
        
        switch self.style {
        case .Blue:
            print("Blue")
            self.backgroundColor = UIColor(red: 0.00, green: 0.67, blue: 0.91, alpha: 1.0)
            self.layer.shadowColor = UIColor(red: 0.00, green: 0.67, blue: 0.91, alpha: 1).cgColor
            
        case .Red:
            print("Red")
            self.backgroundColor = UIColor(red:1.00, green:0.00, blue:0.47, alpha:1.0)
            self.layer.shadowColor = UIColor(red:1.00, green:0.00, blue:0.47, alpha:1.0).cgColor
            
        case .Yellow:
            print("Yellow")
            self.backgroundColor = UIColor(red: 1.00, green: 0.74, blue: 0.07, alpha: 1.0)
            self.layer.shadowColor = UIColor(red: 1.00, green: 0.74, blue: 0.07, alpha: 1.0).cgColor
            
        }
        
    }
    
    func drawTextLabel() {
    
        self.textLabel.frame = self.bounds
        
        
    }
    
    
    //MARK: Touch Event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.7
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.sendActions(for: .touchUpInside)
    }
    
    

}
