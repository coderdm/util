//
//  ViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtFieldPassword: UITextField!

    @IBOutlet weak var btnPayForAnother: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    @IBOutlet weak var imagePayForAnotherSelected: UIImageView!
    @IBOutlet weak var imageLoginSelected: UIImageView!
    
    var loginTabSelected : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePayForAnotherSelected.isHidden = true;
    
        self.txtFieldPassword.delegate = self
        //Setting the logo of UTIL to the navigation bar
        let logo = UIImage(named: "nav-logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        //For Removing the bottom black line in navigation bar
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Changing the navigation bar color
        navigationController?.navigationBar.barTintColor = UIColor.utlSlate
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func PayForAnotherTabSelected(_ sender: Any) {
        self.loginTabSelected = false
        self.imagePayForAnotherSelected.isHidden = false
        self.imageLoginSelected.isHidden = true
        self.btnPayForAnother.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldPassword.isHidden = true
    }

    @IBAction func LoginTabSelected(_ sender: Any) {
        self.loginTabSelected = true
        self.imagePayForAnotherSelected.isHidden = true
        self.imageLoginSelected.isHidden = false
        self.btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.btnPayForAnother.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldPassword.isHidden = false
    }
    
    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        
        if self.loginTabSelected {
            self.performSegue(withIdentifier: "segueToTabbarController", sender: self)
        }else{
            self.performSegue(withIdentifier: "segueToPayForAnother", sender: self)
        }
        
    }
    
    
}

