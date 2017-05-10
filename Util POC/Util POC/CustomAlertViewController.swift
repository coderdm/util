//
//  ServiceAlertViewController.swift
//  VirtualClaudia
//
//  Created by Soni, Ankita (US - Bengaluru) on 12/14/16.
//  Copyright © 2016 Eli Lilly & Co. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    fileprivate let TransparentBackgroundAlpha = 0.7
    
    @IBOutlet weak var transparentBackgroundView: UIView!
    @IBOutlet weak var alertContainerView: UIView!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    var okActionBlock: (() -> ())?
    
    //--------------------------------------------------------------------------
    // MARK: View Lifecycle
    //--------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentBackgroundView.backgroundColor = UIColor.black
        transparentBackgroundView.alpha = CGFloat(TransparentBackgroundAlpha)
        alertContainerView.backgroundColor = UIColor.white
        okButton.setTitleColor(UIColor.utlWatermelon, for: .normal)
        alertContainerView.cornerRadius = 20
    }
    
    //--------------------------------------------------------------------------
    // MARK: IBActions
    //--------------------------------------------------------------------------
    
    @IBAction func actionButtonTapped(_ sender: AnyObject) {
        self.removeAlert()
        if let okActionBlock = okActionBlock {
            okActionBlock()
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: Custom Methods
    //--------------------------------------------------------------------------
    
    private func removeAlert() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    func setValue(alertConImage: UIImage, alertMessage:String, buttonTitle: String) {
        okButton.setTitle(buttonTitle, for: .normal)
        descLabel.text = alertMessage
        alertImage.image = alertConImage
    }
        
}
