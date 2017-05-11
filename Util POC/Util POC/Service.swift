//
//  Services.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/11/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class Service: NSObject {
    
    var serviceType:String = ""
    var ecomonyType:String = ""
    var validTillDate:String = ""

    init(serviceType:String , ecomonyType:String , validTillDate:String){
        self.serviceType = serviceType
        self.ecomonyType = ecomonyType
        self.validTillDate = validTillDate
    }
}
