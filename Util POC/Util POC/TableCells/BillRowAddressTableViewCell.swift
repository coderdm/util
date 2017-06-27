//
//  BillRowAddressTableViewCell.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 27/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class BillRowAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var expandableImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
