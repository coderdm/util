//
//  OutageHistoryService.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/26/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

protocol OutageHistoryServiceDelegate {
    func outageHistory(outages : [Outage])
}

class OutageHistoryService: NSObject {

    var delegate:OutageHistoryServiceDelegate?
    var outages = [Outage]()
    
    func getOutageHistory() {
        
        //let url = NSURL(string: "http://socwes1er46.solutions.glbsnet.com:8000/sap/opu/odata/sap/ZUTIL_APP_SRV/Notif_mainSet")
        let url = NSURL(string: "https://desolate-cliffs-96575.herokuapp.com/fetchcomplaints")
        var request = URLRequest.init(url:url! as URL)
        request.requestWithAuthorizationHeader(username: "vmeghmala", password: "vivsap001")
        NetworkManager.sharedNetworkManagerInstance.performDataTaskWithRequest(request:request) { (result : Any , response:URLResponse)  in
            
            if let jsonResult = result as? Dictionary<String, AnyObject> {
                print(jsonResult["d"]!)
                
                let results = jsonResult["d"]!
                let resultsArray = results["results"]! as! [[String : Any]]
                
                self.parseOutageHistory(results: resultsArray)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if let csrfToken = httpResponse.allHeaderFields["x-csrf-token"] as? String {
                    UserDefaults.standard.set(csrfToken, forKey: "csrfToken")
                }
            }
        }
    }
    
    func parseOutageHistory(results : [[String : Any]]){
        
        for outageItem in results{
            let bPart = outageItem["Bpart"] as! String
            let outageType = outageItem["OutageType"] as! String
            let latitude = outageItem["LatiServAdd"] as! String
            let longitude = outageItem["LongServAdd"] as! String
            let referenceNumber = outageItem["Qmnum"] as! String
            let issueDate = outageItem["IssueDate"] as! String
            let issueStaus = outageItem["IssueStatus"] as! String
            
            let outage = Outage(bPart: bPart, outageType: outageType, issueRaisedDate: issueDate, issueStatus: issueStaus, referenceNumber: referenceNumber, latitude: latitude, longitude: longitude)
            
            outages.append(outage)
            
        }
        
        if self.delegate != nil && self.delegate?.outageHistory(outages: outages) != nil  {
            
        }

        
    }
}
