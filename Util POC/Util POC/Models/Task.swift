//
//  Task.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/26/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class Task {

    var url: String
    var isProcessing = false
    var progress: Float = 0.0
    
    var dataTask: URLSessionDataTask?
    var resumeData: Data?
        
    init(url: String) {
        self.url = url
    }    
}
