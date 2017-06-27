//
//  AccountDetailsService.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/13/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

protocol AccountDetailsServiceDelegate {
    func accountDetails(accountDetails : AccountDetails)
}

class AccountDetailsService{
    
    
    var delegate:AccountDetailsServiceDelegate?
    
    func getAccountDetails(){
        
        let url = NSURL(string: "http://socwes1er46.solutions.glbsnet.com:8000/sap/opu/odata/sap/ZUTIL_APP_SRV/Notif_accountSet?$format=json")
        
        var request = URLRequest.init(url:url! as URL)
        request.requestWithAuthorizationHeader(username: "vmeghmala", password: "vivsap001")
       
        NetworkManager.sharedNetworkManagerInstance.performDataTaskWithRequest(request:request) { (result : Any , response:URLResponse)  in
            
            if let jsonResult = result as? Dictionary<String, AnyObject> {
                print(jsonResult["d"]!)
                
                let results = jsonResult["d"]!
                let resultsArray = results["results"]! as! [[String : Any]]
                self.parse(results: resultsArray)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if let csrfToken = httpResponse.allHeaderFields["x-csrf-token"] as? String {
                    UserDefaults.standard.set(csrfToken, forKey: "csrfToken")
                }
            }
        }

       
    }
    
    func parse(results : [[String : Any]]){
        
        if results.count > 0 {
            var accountDetailItem = results[0]
            
            let accountNumber = accountDetailItem["Bpart"] as! String
            let firstName = accountDetailItem["FirstName"] as! String
            let lastName = accountDetailItem["LastName"] as! String
            let dateOfBirth = accountDetailItem["Dob"] as! String
            let phoneNumber = accountDetailItem["Phone"] as! String
            let address = accountDetailItem["Address"] as! String
            //let email = accountDetailItem["Email"] as! String
            let email = "dd@deloitte.com"
            
            let accountDetails = AccountDetails(firstName: firstName, lastName: lastName, accountNumber: accountNumber, address: address, email: email, phoneNumber: phoneNumber, dateOfBirth: dateOfBirth)
            
            if self.delegate != nil && self.delegate?.accountDetails(accountDetails: accountDetails) != nil  {
                
            }
            
        }
        
        
        
    }

    
}
