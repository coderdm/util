//
//  DetailsViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var serviceViewDetail1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var service1Button: UIButton!
  
    var isView1Shown:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .utlSunflowerYellow
        navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
        
        serviceViewDetail1HeightConstraint.constant = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.visibleViewController?.navigationItem.addNavigationView(withImage: "accountIcon", title: "Account Details")
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = nil
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
