//
//  Utils.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/7/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation
import CoreLocation

class Utils{
    static let sharedNetworkManagerInstance = Utils()
    
    func reverseGeocodeFromLatitudeLongitude(latitude : Double , longitude : Double){
        
        let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                var placeMark: CLPlacemark?
                placeMark = placemarks?[0]
                
                var address = ""
                
                // Location name
                if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                    address += locationName + ", "
                }
                
                // Street address
                if let street = placeMark?.addressDictionary?["Thoroughfare"] as? String {
                    address += street + ", "
                }
                
                // City
                if let city = placeMark?.addressDictionary?["City"] as? String {
                    address += city + ", "
                }
                
                // Zip code
                if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
                    address += zip + ", "
                }
                
                // Country
                if let country = placeMark?.addressDictionary?["Country"] as? String {
                    address += country
                }
                
                print("address \(address)")
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
    }
}

