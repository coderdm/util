//
//  String.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 6/7/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import Foundation

extension String{
    
    func formatddMMYYYY() -> Date{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.date(from:self)
        return formattedDate! 
    }
    
}
