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
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var accountNumberField: UITextField!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var ssnTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.backgroundColor = UIColor.utlSlate
        cancelButton.tintColor = UIColor.utlSunflowerYellow
        nextButton.tintColor = UIColor.utlSunflowerYellow
        contentLabel.font = UIFont.italicSystemFont(ofSize: 12)
        contentLabel.textColor = UIColor.utlWarmGrey
        accountNumberField.useUnderline()
        ssnTextField.useUnderline()
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
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController!.isNavigationBarHidden = false
       let _ =  navigationController?.popToRootViewController(animated: false)
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
extension SignUpIntroViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
