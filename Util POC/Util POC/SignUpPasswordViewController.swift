//
//  SignUpPasswordViewController.swift
//  Util POC
//
//  Created by M, Dileep (US - Bengaluru) on 5/9/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var elecImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var footerView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.useUnderline()
        confirmPasswordField.useUnderline()
        backButton.tintColor = UIColor.utlSunflowerYellow
        nextButton.tintColor = UIColor.utlSunflowerYellow
        pageControl.tintColor = UIColor.utlSunflowerYellow
        footerView.backgroundColor = UIColor.utlSlate
        
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
    

    // MARK: - IBAction
    
    @IBAction func backAction(_ sender: Any) {
       let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        navigationController!.isNavigationBarHidden = false
        let _ = navigationController?.popToRootViewController(animated: false)
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
extension SignUpPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
