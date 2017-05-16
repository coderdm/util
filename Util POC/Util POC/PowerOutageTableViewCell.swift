//
//  PowerOutageTableViewCell.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 04/05/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class PowerOutageTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHeaderDate: UILabel!

    @IBOutlet weak var statusImageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSubOutageType: UILabel!
    @IBOutlet weak var lblHeaderOutage: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var lblReferenceNumberHeader: UILabel!
    @IBOutlet weak var outageHeaderLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblReferenceNumber: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
       
        self.setupViews()
    }
    
    func setupViews(){
        
        self.lblHeaderDate.textColor = UIColor.utlSunflowerYellow
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 480:
                print("iPhone Classic")
            case 960:
                print("iPhone 4 or 4S")
            case 1136:
                self.outageHeaderLabelLeadingConstraint.constant = 20.0
                self.statusImageViewTrailingConstraint.constant = 40.0
                self.statusImageViewLeadingConstraint.constant = 40.0
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
