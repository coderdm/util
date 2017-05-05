//
//  Issue.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 04/05/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class Issue: NSObject {
    var issueType:String = ""
    var dateReported:String = ""
    var issueAddress:String = ""
    var status:String = ""
    var lat:String = ""
    var long:String = ""
    
    init(issueType:String, dateReported:String, issueAddress:String, status:String, lat:String, lon:String) {
        self.issueType = issueType
        self.dateReported = dateReported
        self.issueAddress = issueAddress
        self.status = status
        self.lat = lat
        self.long = lon
    }
}
