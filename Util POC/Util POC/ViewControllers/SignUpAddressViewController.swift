//
//  signUpAddressViewController.swift
//  Util POC
//
//  Created by M, Dileep (US - Bengaluru) on 5/9/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class SignUpAddressViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var pipeImageView: UIImageView!
    @IBOutlet weak var contactDetailsLabel: UILabel!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var resAddressLabel: UILabel!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var pincodeField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var footerView: UIView!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.backgroundColor = UIColor.utlSlate
        backButton.tintColor = UIColor.utlSunflowerYellow
        nextButton.tintColor = UIColor.utlSunflowerYellow
        pageControl.tintColor = UIColor.utlSunflowerYellow
        phoneNumberField.useUnderline()
        emailAddressField.useUnderline()
        addressField.useUnderline()
        pincodeField.useUnderline()
        cityField.useUnderline()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.navigationController!.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    // MARK: - IBActions
  
    @IBAction func backAction(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
    }
    
    // MARK: - Keyboard Hide/Show
    
    func keyboardWillShow(_ notification: Notification) {
        let info:  [AnyHashable: Any]? = notification.userInfo!
        if let keyboardSize = (info?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets: UIEdgeInsets? = UIEdgeInsetsMake(contentScrollView.contentInset.top, contentScrollView.contentInset.left, (keyboardSize.height), contentScrollView.contentInset.right)
            contentScrollView.contentInset = contentInsets!
            contentScrollView.scrollIndicatorInsets = contentInsets!
        }
    }
    func keyboardWillHide(_ notification: Notification) {
        contentScrollView.contentInset = UIEdgeInsets.zero
        contentScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

}

// MARK: - UITextFieldDelegate
extension SignUpAddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
