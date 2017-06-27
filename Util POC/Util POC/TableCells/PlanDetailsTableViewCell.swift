//
//  PlanDetailsTableViewCell.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/15/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class PlanDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentDetailsLabelLeadingConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 480:
                print("iPhone Classic")
            case 960:
                print("iPhone 4 or 4S")
            case 1136:
                self.paymentDetailsLabelLeadingConstraint.constant = 20.0
            case 1334:
                print("iPhone 6 or 6S")
            case 2208:
                print("iPhone 6+ or 6S+")
            default:
                print("unknown")
            }
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
