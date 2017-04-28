//
//  UINavigationItem.swift
//  Util POC
//
//  Created by M, Dileep (US - Bengaluru) on 4/28/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

private enum NavigationViewConstants {
    static let width  = 300
    static let height  = 40
    static let titleFontSize = 14
}

extension UINavigationItem {
    
    func addNavigationView(withImage imageName:String, title: String) {
        // Create a navView to add to the navigation bar
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: NavigationViewConstants.width, height: NavigationViewConstants.height))
        
        // Create the label
        let label = UILabel()
        label.text = title
        label.sizeToFit()
        label.textColor = .utlSlate
        label.font = UIFont.systemFont(ofSize: CGFloat(NavigationViewConstants.titleFontSize))
        label.textAlignment = .center
        
        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height

        image.frame = CGRect(x: (navView.frame.size.width/2) - (navView.frame.size.height*imageAspect)/2, y: 0, width: navView.frame.size.height*imageAspect, height: navView.frame.size.height/2)
        label.frame = CGRect(x: 0, y: image.frame.size.height  , width: navView.frame.size.width, height: navView.frame.size.height - (image.frame.size.height ))

        image.contentMode = UIViewContentMode.scaleAspectFit
        
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }
}
