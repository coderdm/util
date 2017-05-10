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
    
    // To check if alert is displayed
    var isAlertDisplayed = false
    
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
    
    // MARK: - Utils
    private func showServiceErrorAlert(imageName: String, message: String, buttonTitle: String, success: Bool) {
        if !isAlertDisplayed {
            let storyboard = UIStoryboard.init(name: "Generic", bundle: nil)
            let alertController  = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
            addChildViewController(alertController)
            isAlertDisplayed = true
            view.addView(view: alertController.view, topConstraint: NSNumber.init(value: 0), bottomConstraint: NSNumber.init(value: 0), leadingConstraint: NSNumber.init(value: 0), trailingConstraint: NSNumber.init(value: 0))
            alertController.okActionBlock = { [weak self] in
                guard let strongSelf = self else { return}
                strongSelf.isAlertDisplayed = false
                if success {
                    strongSelf.navigationController!.isNavigationBarHidden = false
                    let _ = strongSelf.navigationController?.popToRootViewController(animated: false)
                }
            }
            let errorImage = UIImage(named: imageName) ?? UIImage()
            alertController.setValue(alertConImage: errorImage, alertMessage: message, buttonTitle: buttonTitle)

        }
    }
    
    func register() {
        var a = false
        var b = false
        
        if passwordField.text == confirmPasswordField.text {
            a = true
        } else {
            showServiceErrorAlert(imageName: "safetyCautionRed", message: "Your passwords do not match", buttonTitle: "Ok", success: false)
        }
        
        if(passwordField.text == "" || confirmPasswordField.text == "") {
            showServiceErrorAlert(imageName: "safetyCautionRed", message: "Your password fields cannot be empty", buttonTitle: "Ok", success: false)
        } else {
            b = true
        }
        
        if a == true && b == true {
            showServiceErrorAlert(imageName: "success", message: "You have successfully registered your account!", buttonTitle: "Ok", success: false)
        }
    }
    
    
    // MARK: - IBAction
    
    @IBAction func backAction(_ sender: Any) {
       let _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func nextAction(_ sender: Any) {
        register()
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
