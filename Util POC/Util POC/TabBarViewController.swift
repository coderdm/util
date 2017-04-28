//
//  TabBarViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.barTintColor = .utlSunflowerYellow
        navigationController?.navigationBar.isTranslucent = true
        
        tabBar.barTintColor = .utlSlate
        UITabBar.appearance().tintColor = .utlSunflowerYellow
    }

}
