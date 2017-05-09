//
//  MapViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 09/05/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit
import MapKit
public typealias complaintFormat = (coordinate: CLLocationCoordinate2D, messageType: String)

class MapViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var locationManager:CLLocationManager = CLLocationManager()
    var coordinateArray:[complaintFormat] = [complaintFormat]()

    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        locationManager.delegate = self
        self.mapview.delegate = self
        
        self.mapview.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func generateComplaintAnnotation(location:CLLocation){

        for index in 1...15 {
            
            let latitude = (drand48().truncatingRemainder(dividingBy:20)) + (location.coordinate.latitude)
            let longitude = (location.coordinate.longitude)  + drand48().truncatingRemainder(dividingBy:10)
            
            let randomCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            if(CLLocationCoordinate2DIsValid(randomCoordinate) == true)
            {    let annotation = MKPointAnnotation()

                if index < 5 && index > 0 {
                    annotation.title = "PowerOutage"
                    coordinateArray.append((randomCoordinate, "PowerOutage"))
                }
                if index > 5 && index < 11 {
                    annotation.title = "StreetlightOutage"
                    coordinateArray.append((randomCoordinate, "StreetlightOutage"))
                }
                if index > 10 && index < 16 {
                    annotation.title = "SafetyConcern"
                    coordinateArray.append((randomCoordinate, "SafetyConcern"))
                }
                annotation.coordinate = CLLocationCoordinate2D(latitude: randomCoordinate.latitude, longitude: randomCoordinate.longitude)
                mapview.addAnnotation(annotation)
            }
            
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        annotation.title = "CurrentCoordinate"
        mapview.addAnnotation(annotation)
        
        self.zoomToFitMapAnnotations()
        //self.mapview.showAnnotations(self.mapview.annotations, animated: true)
    }
    
    func zoomToFitMapAnnotations() {
        guard self.mapview.annotations.count > 0 else {
            return
        }
        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        topLeftCoord.latitude = -90
        topLeftCoord.longitude = 180
        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        bottomRightCoord.latitude = 90
        bottomRightCoord.longitude = -180
        for annotation: MKAnnotation in self.mapview.annotations{
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }
        
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.4
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.4
        region = self.mapview.regionThatFits(region)
        self.mapview.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationmanager got called")
        let location = locations.last!
        self.generateComplaintAnnotation(location: location)
        locationManager.stopUpdatingLocation()

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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let reuseId = "annotation"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            if (annotation.title)! == "PowerOutage" {
                anView?.image = UIImage(named:"powerRed")
                anView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
            if (annotation.title)! == "StreetlightOutage" {
                anView?.image = UIImage(named:"streetRed")
                anView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
            if (annotation.title)! == "SafetyConcern" {
                anView?.image = UIImage(named:"safetyCautionRed")
                anView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
            if (annotation.title)! == "CurrentCoordinate" {
                anView?.image = UIImage(named:"gpsIcon")
                //anView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        return anView
    }
}

