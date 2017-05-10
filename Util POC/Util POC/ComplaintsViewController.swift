//
//  ComplaintsViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit
import CoreLocation

class ComplaintsViewController: UIViewController, UINavigationControllerDelegate {
    
    // IBOutlets
    
    // Call View
    @IBOutlet weak var callBorderView: UIView!
    @IBOutlet weak var callTextLabel: UILabel!
    @IBOutlet weak var callButton: NSLayoutConstraint!
    
    // Choose Outage View
    @IBOutlet weak var outageTextLabel: UILabel!
    @IBOutlet weak var outageBorderView: UIView!
    @IBOutlet weak var dropDownButton: UIButton!
    
    // Address Fields
    @IBOutlet weak var lblAddressField: UITextField!
    @IBOutlet weak var addressBorderView: UIView!
    
    // Add Image view
    @IBOutlet weak var addImageTitleLabel: UILabel!
    @IBOutlet weak var btnOpenCamera: UIButton!
    @IBOutlet weak var imageViewPreview: UIImageView!
    @IBOutlet weak var imageViewPreview1: UIImageView!
    @IBOutlet weak var imageViewPreview2: UIImageView!
    @IBOutlet weak var btnRemoveImagePreview: UIButton!
    @IBOutlet weak var btnRemoveImagePreview2: UIButton!
    @IBOutlet weak var btnRemoveImagePreview1: UIButton!
    
    // Submit button
    @IBOutlet weak var submitButton: UIButton!
    
    // To check if alert is displayed
    var isAlertDisplayed = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    let imagePicker = UIImagePickerController()
    var locationManager:CLLocationManager = CLLocationManager()
    var mutableArrayContainingNumbers:[Int] = [Int]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callBorderView.backgroundColor = UIColor.utlWarmGrey.withAlphaComponent(0.25)
        callTextLabel.textColor = UIColor.utlSlate.withAlphaComponent(0.85)
        
        outageBorderView.backgroundColor = UIColor.utlWarmGrey.withAlphaComponent(0.25)
        outageTextLabel.textColor = UIColor.utlSlate.withAlphaComponent(0.85)
        
        addressBorderView.backgroundColor = UIColor.utlWarmGrey.withAlphaComponent(0.25)
        addButton(to: lblAddressField)
   
        lblAddressField.layer.cornerRadius = 20
        lblAddressField.layer.borderColor = UIColor.utlWarmGrey.withAlphaComponent(0.25).cgColor
        lblAddressField.layer.borderWidth = 1.0
        
        addImageTitleLabel.text = "Add photos"
        addImageTitleLabel.textColor = UIColor.utlSlate.withAlphaComponent(0.85)
        
        submitButton.backgroundColor = UIColor.utlRedPink
        submitButton.layer.cornerRadius = submitButton.frame.size.height/2
        
        self.locationManager.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = " "
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        navigationController?.visibleViewController?.navigationItem.addNavigationView(withImage: "telemarketer", title: "Complaints")
    }
    
     // MARK: - Custom
    
   func checkCameraButtonStatus() {
        if self.imageViewPreview.image != nil && self.imageViewPreview1.image != nil && self.imageViewPreview2.image != nil {
            self.btnOpenCamera.isHidden = true
        }
        else {
            self.btnOpenCamera.isHidden = false
        }
    }

    private func showAlert(imageName: String, message: String, buttonTitle: String, completion: (() -> ())?) {
        if !isAlertDisplayed {
            let storyboard = UIStoryboard.init(name: "Generic", bundle: nil)
            let alertController  = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
            addChildViewController(alertController)
            isAlertDisplayed = true
            view.addView(view: alertController.view, topConstraint: NSNumber.init(value: 0), bottomConstraint: NSNumber.init(value: 0), leadingConstraint: NSNumber.init(value: 0), trailingConstraint: NSNumber.init(value: 0))
            alertController.okActionBlock = { [weak self] in
                guard let strongSelf = self else { return}
                strongSelf.isAlertDisplayed = false
                if let completion = completion {
                    completion()
                }
            }
            let errorImage = UIImage(named: imageName) ?? UIImage()
            alertController.setValue(alertConImage: errorImage, alertMessage: message, buttonTitle: buttonTitle)
            
        }
    }

    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func showOutageSelection() {
        // Create the AlertController and add its actions like button in ActionSheet
        let actionSheetController = UIAlertController(title: "Please Choose", message: "Outage Type", preferredStyle: .actionSheet)
        
        let streetLightOutage = UIAlertAction(title: "Streetlight Outage", style: .default) { action -> Void in
            self.outageTextLabel.text = "Streetlight Outage"
        }
        actionSheetController.addAction(streetLightOutage)
        
        
        let damageElectricPoleButton = UIAlertAction(title: "Safety Concern", style: .default) { action -> Void in
            self.outageTextLabel.text = "Safety Concern"
        }
        actionSheetController.addAction(damageElectricPoleButton)
        
        
        let noPowerSupplyButton = UIAlertAction(title: "Power Outage", style: .default) { action -> Void in
            self.outageTextLabel.text = "Power Outage"
        }
        actionSheetController.addAction(noPowerSupplyButton)
        

        let otherOutage = UIAlertAction(title: "Other", style: .default) { action -> Void in
            self.outageTextLabel.text = "Other"
        }
        actionSheetController.addAction(otherOutage)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        //stop updating location to save battery life
        locationManager.stopUpdatingLocation()
        self.lblAddressField.text = self.getAddressString(placemark: placemark)
    }
    
    func getAddressString(placemark: CLPlacemark) -> String? {
        var originAddress : String?
        
        if let addrList = placemark.addressDictionary?["FormattedAddressLines"] as? [String]
        {
            originAddress =  addrList.joined(separator: ", ")
        }
        
        return originAddress
    }
    
    func addButton(to textField: UITextField) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(UIImage(named: "gpsIcon"), for: .normal)
        button.addTarget(self, action:#selector(btnGetAddressLocationTapped(_:)), for: .touchUpInside)
        textField.rightViewMode = UITextFieldViewMode.always
        textField.rightView = button
    }

    
    // MARK: - IBAction
    @IBAction func callAction(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Call 911", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            self.callNumber(phoneNumber: "911")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnGetAddressLocationTapped(_ sender: Any) {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func outageSelectionAction(_ sender: Any) {
        showOutageSelection()
    }
    
    
    @IBAction func capturePhotoTapped(_ sender: Any) {
        imagePicker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnRemoveImagePreview1(_ sender: Any) {
        self.imageViewPreview.image = nil
        self.btnRemoveImagePreview.isHidden = true
        self.checkCameraButtonStatus()
    }
    @IBAction func btnRemoveImagePreview2(_ sender: Any) {
        self.imageViewPreview1.image = nil
        self.btnRemoveImagePreview1.isHidden = true
        self.checkCameraButtonStatus()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        if self.outageTextLabel.text == "Choose Outage Type" {
            showAlert(imageName: "safetyCautionRed", message: "Please choose outage type", buttonTitle: "Ok", completion: nil)
            return
        }
        if (self.lblAddressField.text?.isEmpty)! {
            showAlert(imageName: "safetyCautionRed", message: "Please provide the address", buttonTitle: "Ok", completion: nil)
            return
            
        }
        let referenecNumber = String(self.randomNumber())
        let issue = Issue(issueType: self.outageTextLabel.text!, dateReported: self.dateFormatMMDDYYYY(for: Date.init()), issueAddress: self.lblAddressField.text!, status: "Report Submitted", lat: "25.7617", lon: "80.1918" , referenceNumber : referenecNumber)
        
        appDelegate.issue.insert(issue, at: 0)
        showAlert(imageName: "mail-icon", message: "Thank you! your notification has been received. Your reference number is \(referenecNumber)", buttonTitle: "Ok",completion: {
        })
    }
    @IBAction func btnRemoveImagePreview3(_ sender: Any) {
        self.imageViewPreview2.image = nil
        self.btnRemoveImagePreview2.isHidden = true
        self.checkCameraButtonStatus()
    }
    
    // MARK: - Utils
    func dateFormatMMDDYYYY(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "GMT")! as TimeZone
        return dateFormatter.string(from:date)
    }
    
    func randomNumber() -> Int {
        
        let randomNumber = Int(arc4random())
        if mutableArrayContainingNumbers.contains(Int(randomNumber)) {
            self.randomNumber()
            // call the method again and get a new object
        }
        else {
            // end case, it doesn't contain it so you have a number you can use
            mutableArrayContainingNumbers.append(Int(randomNumber))
            return randomNumber
        }
        return randomNumber
    }
}

// MARK: - CLLocationManagerDelegate

extension ComplaintsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationmanager got called")
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(placemark: pm!)
            } else {
                print("Problem with the data received from geocoder")
            }
        })

    }
      
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.notDetermined, CLAuthorizationStatus.restricted, CLAuthorizationStatus.denied:
            print ("Error: Permission denied")
            break
        default:
            locationManager.startUpdatingLocation()
            break
        }
    }
}

// MARK: -  UIImagePickerControllerDelegate

extension ComplaintsViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil);
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if self.imageViewPreview.image == nil {
                self.imageViewPreview.image = image
                self.btnRemoveImagePreview.isHidden = false
            } else if self.imageViewPreview1.image == nil {
                self.imageViewPreview1.image = image
                self.btnRemoveImagePreview1.isHidden = false
            } else if self.imageViewPreview2.image == nil {
                self.imageViewPreview2.image = image
                self.btnRemoveImagePreview2.isHidden = false
            }
            
            self.checkCameraButtonStatus()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
