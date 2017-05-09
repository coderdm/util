//
//  signUpPersonalDetailsViewController.swift
//  Util POC
//
//  Created by M, Dileep (US - Bengaluru) on 5/9/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class SignUpPersonalDetailsViewController: UIViewController {
    
    // IBOutlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var inputStackView: UIStackView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.backgroundColor = UIColor.utlSlate
        pageControl.tintColor = UIColor.utlSunflowerYellow
        backButton.tintColor = UIColor.utlSunflowerYellow
        nextButton.tintColor = UIColor.utlSunflowerYellow
        firstNameField.useUnderline()
        lastNameField.useUnderline()
        dobField.useUnderline()
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

    @IBAction func backButtonAction(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
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
extension SignUpPersonalDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
