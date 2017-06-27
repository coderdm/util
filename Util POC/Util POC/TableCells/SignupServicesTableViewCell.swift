
//
//  SignupServicesTableViewCell.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/11/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class SignupServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var economyTypeLabel: UILabel!
    @IBOutlet weak var validTillLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
