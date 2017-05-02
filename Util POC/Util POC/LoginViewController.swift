//
//  ViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtFieldPassword: UITextField!

    @IBOutlet weak var btnPayForAnother: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    @IBOutlet weak var imagePayForAnotherSelected: UIImageView!
    @IBOutlet weak var imageLoginSelected: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePayForAnotherSelected.isHidden = true;
        
        //Setting the logo of UTIL to the navigation bar
        let logo = UIImage(named: "nav-logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        //Changing the navigation bar color
        navigationController?.navigationBar.barTintColor = UIColor.utlSlate
        
        
        //For Removing the bottom black line in navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    @IBAction func PayForAnotherTabSelected(_ sender: Any) {
        self.imagePayForAnotherSelected.isHidden = false
        self.imageLoginSelected.isHidden = true
        self.btnPayForAnother.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldPassword.isHidden = true
    }

    @IBAction func LoginTabSelected(_ sender: Any) {
        self.imagePayForAnotherSelected.isHidden = true
        self.imageLoginSelected.isHidden = false
        self.btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.btnPayForAnother.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldPassword.isHidden = false
    }
}

