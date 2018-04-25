//
//  AuthenticationService.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/28/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

protocol AuthenticationServiceDelegate {
    func authenticationSuccess(success : Bool)
}

class AuthenticationService {
    
    var delegate : AuthenticationServiceDelegate?
    
    func authenticate(accountNumber : String , ssnNumber : String){
        //let url = NSURL(string: AppUrl.AuthenticationUrl(withBPart: "1000000014", ssn: "0000"))
        let url = NSURL(string: "https://desolate-cliffs-96575.herokuapp.com/loginutil")
        
        
        var request = URLRequest.init(url:url! as URL)
        request.requestWithAuthorizationHeader(username: "vmeghmala", password: "vivsap001")
        
        NetworkManager.sharedNetworkManagerInstance.performDataTaskWithRequest(request:request) { (result : Any , response:URLResponse)  in
            
            if let jsonResult = result as? Dictionary<String, AnyObject> {
                print(jsonResult["d"]!)
                
                let results = jsonResult["d"]!
                
                self.parse(results: results as! [String : Any])
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if let csrfToken = httpResponse.allHeaderFields["x-csrf-token"] as? String {
                    UserDefaults.standard.set(csrfToken, forKey: "csrfToken")
                }
            }
        }
        
    }
    
    func parse(results : [String : Any]){
        
        let successMessage = results["Message"] as! String
        let success : Bool = successMessage == "User Authenticated" ? true : false
        
        if self.delegate != nil && self.delegate?.authenticationSuccess(success: success) != nil{
            
        }
            
    }
  
}

