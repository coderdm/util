//
//  URLRequest.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/1/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

extension URLRequest{
    
    mutating func requestWithAuthorizationHeader(username : String , password : String){
        
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        self.httpMethod = "GET"
        self.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        self.addValue("Fetch", forHTTPHeaderField: "X-CSRF-Token")
    }
    
    mutating func requestWithAuthorizationTokenHeader(token : String){
        
        let loginString = String(format: "%@:%@", "vmeghmala", "vivsap001")
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        self.httpMethod = "POST"
        self.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        self.addValue(token, forHTTPHeaderField: "X-CSRF-Token")
    }
}
