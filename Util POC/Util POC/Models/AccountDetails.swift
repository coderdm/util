//
//  AccountDetails.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/14/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

class AccountDetails: NSObject {
    
    var firstName = ""
    var lastName = ""
    var accountNumber = ""
    var address = ""
    var email = ""
    var phoneNumber = ""
    var dateOfBirth = ""
    
    init(firstName : String,lastName : String,accountNumber : String,address : String,email : String,phoneNumber : String,dateOfBirth : String){
        super.init()
        
        self.accountNumber = accountNumber
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.address = address
        
    }
    
}
