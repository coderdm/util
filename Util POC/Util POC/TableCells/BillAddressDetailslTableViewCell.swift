//
//  BillAddressDetailslTableViewCell.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/12/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

protocol BillAddressDetailsDelegate {
    func expandIconTapped()
}

class BillAddressDetailslTableViewCell: UITableViewCell {

    @IBOutlet weak var expandIconButton: UIButton!
    var delegate:BillAddressDetailsDelegate?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var readingHolderView: UIView!
    
    @IBOutlet weak var readingHolderViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var billDetailHeaderLabelLeadingConstraint: NSLayoutConstraint!
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
                self.billDetailHeaderLabelLeadingConstraint.constant = 20
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
    
    // MARK: -  Action methods
    @IBAction func expandIconTapped(_ sender: Any) {
        delegate?.expandIconTapped()
    }

}
