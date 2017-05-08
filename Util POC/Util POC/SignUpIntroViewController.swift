//
//  SignUpIntroViewController.swift
//  Util POC
//
//  Created by M, Dileep (US - Bengaluru) on 5/8/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class SignUpIntroViewController: UIViewController {
    
    
    // IBoutlets
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    // Mark: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.backgroundColor = UIColor.utlSlate
        cancelButton.tintColor = UIColor.utlSunflowerYellow
        nextButton.tintColor = UIColor.utlSunflowerYellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.isNavigationBarHidden = true
        
    }
    
}
