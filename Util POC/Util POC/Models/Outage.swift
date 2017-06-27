//
//  Outage.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/6/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

class Outage : NSObject{
    
    var bPart : String = ""
    var outageType : String = ""
    var issueRaisedDate : Date?
    var issueRaisedDateString : String = ""
    var issueStatus : String = ""
    var referenceNumber = ""
    var latitude : Double?
    var longitude : Double?
    var address : String?
    
    init(bPart: String,outageType: String ,issueRaisedDate : String, issueStatus: String , referenceNumber:String , latitude : String , longitude : String){
        
        super.init()
        self.bPart = bPart
        self.issueRaisedDateString = issueRaisedDate
        self.issueRaisedDate = issueRaisedDate.formatddMMYYYY()
        self.issueStatus = self.issueStatusFromAbbrevated(statusCode: issueStatus)
        self.referenceNumber = referenceNumber
        self.outageType = outageType
        
        self.longitude = Double(longitude)
        self.latitude = Double(latitude)
        
        
       
//        Utils.sharedNetworkManagerInstance.reverseGeocodeFromLatitudeLongitude(latitude: self.latitude!, longitude: self.longitude!)
    }
    
    func issueStatusFromAbbrevated(statusCode : String) -> String{
        
        switch statusCode {
        case "RC":
            return "Report Submitted";
        case "DP":
            return "Dispatched";
        case "AC":
            return "Report Accepted";
        case "EN":
            return "En-Route";
        case "AR":
            return "Arrived";
        case "CL":
            return "Resolved";
        default:
            return "Report Submitted";
        }
        
    }
}
