//
//  URLConstants.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/29/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

struct AppUrl {
    
    private struct Domains{
        static let Dev = "http://socwes1er46.solutions.glbsnet.com:8000/"
        static let UAT = "http://socwes1er46.solutions.glbsnet.com:8000/"
        static let QA = "http://socwes1er46.solutions.glbsnet.com:8000/"
        static let Prod = "http://socwes1er46.solutions.glbsnet.com:8000/"
    }
    
    private struct Routes{
        static let Api = "sap/opu/odata/sap/ZUTIL_APP_SRV/"
    }
    
    private static let BaseURL = Domains.Dev + Routes.Api
    
    static func AuthenticationUrl(withBPart : String , ssn : String) -> String{
        return BaseURL + "NOTIF_AUTHSet(Bpart='\(withBPart)',SsnPwd='\(ssn)')?$format=json"
    }
}
