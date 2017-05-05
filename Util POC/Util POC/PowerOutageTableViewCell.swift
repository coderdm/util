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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSubOutageType: UILabel!
    @IBOutlet weak var lblHeaderOutage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
        self.lblHeaderDate.textColor = UIColor.utlSunflowerYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
