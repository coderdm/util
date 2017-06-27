//
//  Bill.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/10/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class Bill {
    var billType:String = ""
    var totalConsumption:String = ""
    var billAmount:String = ""
    var year:String = ""
    
    init(billType:String , totalConsumption:String , billAmount:String , year:String){
        self.billType = billType
        self.totalConsumption = totalConsumption
        self.billAmount = billAmount
        self.year = year
    }

}
