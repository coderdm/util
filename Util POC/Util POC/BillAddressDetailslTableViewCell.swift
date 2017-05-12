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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
