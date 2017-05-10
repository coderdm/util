//
//  UIView.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 04/05/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    
    func addView(view: UIView, topConstraint: NSNumber, bottomConstraint: NSNumber, leadingConstraint: NSNumber, trailingConstraint: NSNumber) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-leadingConstraint-[view]-trailingConstraint-|", options: [], metrics: ["leadingConstraint": leadingConstraint, "trailingConstraint": trailingConstraint], views: ["view": view])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-topConstraint-[view]-bottomConstraint-|", options: [], metrics: ["topConstraint": topConstraint, "bottomConstraint": bottomConstraint], views: ["view": view])
        self.addConstraints(horizontalConstraints)
        self.addConstraints(verticalConstraints)
    }
}
