//
//  ComplaintsViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit
import CoreLocation

class ComplaintsViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var imageViewPreview2: UIImageView!
    
    @IBOutlet weak var imageViewPreview: UIImageView!
    @IBOutlet weak var imageViewPreview1: UIImageView!
    
    @IBOutlet weak var btnRemoveImagePreview: UIButton!
    
    @IBOutlet weak var btnRemoveImagePreview2: UIButton!
    
    @IBOutlet weak var btnRemoveImagePreview1: UIButton!
    
    @IBOutlet weak var lblAddressField: UITextField!
    @IBOutlet weak var btnOpenCamera: UIButton!
    let imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    @IBAction func btnRemoveImagePreview3(_ sender: Any) {
        self.imageViewPreview2.image = nil
        self.btnRemoveImagePreview2.isHidden = true
        self.checkCameraButtonStatus()
    }
    
    func checkCameraButtonStatus() {
        if self.imageViewPreview.image != nil && self.imageViewPreview1.image != nil && self.imageViewPreview2.image != nil {
            self.btnOpenCamera.isHidden = true
        }
        else {
            self.btnOpenCamera.isHidden = false
        }
    }
    
    @IBAction func btnGetAddressLocationTapped(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!)
    {        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
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
    
    func displayLocationInfo(placemark: CLPlacemark) {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
//            print(placemark.locality ? placemark.locality! : "")
//            print(placemark.postalCode ? ? placemark.postalCode : "")
//            print(placemark.administrativeArea ? ? placemark.administrativeArea : "")
//            print(placemark.country ? ? placemark.country : "")
        self.lblAddressField.text =  placemark.locality
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
