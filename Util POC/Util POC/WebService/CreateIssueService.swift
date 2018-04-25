//
//  CreateIssueService.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/1/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

protocol CreateIssueServiceDelegate {
    func issueCreatedWithReference(referenceNumber : String)
}

class CreateIssueService {
    
    var delegate:CreateIssueServiceDelegate?
    
    func createAnIssue() {
        
        //let url = NSURL(string: "http://socwes1er46.solutions.glbsnet.com:8000/sap/opu/odata/sap/ZUTIL_APP_SRV/Notif_mainSet")
        let url = NSURL(string: "https://desolate-cliffs-96575.herokuapp.com/addcomplaint")
        var request = URLRequest.init(url:url! as URL)
        //request.requestWithAuthorizationTokenHeader(token: UserDefaults.standard.value(forKey: "csrfToken") as! String)
        request.httpMethod = "POST"
        
        let params = self.createDictForRequest()
        
        NetworkManager.sharedNetworkManagerInstance.performPostDataTaskWithRequest(request: request , parameters: params){ (result : Any , response:URLResponse)  in
            
            if let jsonResult = result as? Dictionary<String, AnyObject> {
                print(jsonResult["d"]!)
                let result = jsonResult["d"]!
                self.parse(results: result as! [String : Any])
            }
            
           
        }
    }
    
    func createDictForRequest() -> Dictionary<String, Any> {
        
        let jsonObject: [String: Any] = [
            "Bpart": "23455"
        ]
        return jsonObject
    }
    
    /*
    func createDictForRequest() -> Dictionary<String, Any> {
        
        let jsonObject: [String: Any] = [
            "Bpart": "",
            "FromDate": "00000000",
            "ToDate": "00000000",
            "Qmtxt": "dummy notification 1",
            "RetMessage": ""
        ]
        return jsonObject
    }
     */
    func parse(results : [String : Any]){
        
        if self.delegate != nil && self.delegate?.issueCreatedWithReference(referenceNumber: results["  "] as! String) != nil  {
            
        }
    }

    
}


