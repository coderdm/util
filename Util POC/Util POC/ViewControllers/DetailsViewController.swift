//
//  DetailsViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,AccountDetailsServiceDelegate {

    @IBOutlet weak var serviceViewDetail1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var service1Button: UIButton!
  
    @IBOutlet weak var logoutButton: UIButton!
    var isView1Shown:Bool = false
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    var loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .utlSunflowerYellow
        // Do any additional setup after loading the view.
        
        serviceViewDetail1HeightConstraint.constant = 0.0
        
        let accountDetailsService = AccountDetailsService()
        accountDetailsService.delegate = self
        
        let storyboard = UIStoryboard.init(name: "Generic", bundle: nil)
        self.loadingViewController  = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        
        self.loadingViewController.show()
        accountDetailsService.getAccountDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.visibleViewController?.navigationItem.addNavigationView(withImage: "accountIcon", title: "Account Details")
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = nil
        logoutButton.layer.borderColor = UIColor.red.cgColor
        logoutButton.layer.borderWidth = 1.0
        logoutButton.layer.cornerRadius = 15.0

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func service1ButtonTapped(_ sender: Any) {
        
        if self.isView1Shown == true{
            
            serviceViewDetail1HeightConstraint.constant = 0.0
            self.service1Button.setBackgroundImage(UIImage(named: "plusButton"), for: .normal)
        }
        else{
            serviceViewDetail1HeightConstraint.constant = 350.0
            self.service1Button.setBackgroundImage(UIImage(named: "minusButton"), for: .normal)

        }
        
        self.isView1Shown = !self.isView1Shown

        
    }

    @IBAction func btnLogouttapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - AccountDetailsServiceDelegate methods

    func accountDetails(accountDetails : AccountDetails){
        
        DispatchQueue.main.async {
            
            self.loadingViewController.stop()
            
            if accountDetails != nil {
                self.firstNameLabel.text = accountDetails.firstName
                self.secondNameLabel.text = accountDetails.lastName
                self.accountNumberLabel.text = accountDetails.accountNumber
                self.phoneNumberLabel.text = accountDetails.phoneNumber
                self.dateOfBirthLabel.text = accountDetails.dateOfBirth
                self.emailLabel.text = accountDetails.email
                
                let words = accountDetails.address.components(separatedBy: ",")
                self.addressLabel.text = words.joined(separator: ",\n")
            }
        }
    }
}
