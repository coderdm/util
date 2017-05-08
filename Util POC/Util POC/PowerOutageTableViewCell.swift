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
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var lblReferenceNumberHeader: UILabel!
    @IBOutlet weak var lblReferenceNumber: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
       
        self.setupViews()
    }
    
    func setupViews(){
        
        self.lblHeaderDate.textColor = UIColor.utlSunflowerYellow
        //self.lblReferenceNumber.font = UIFont(name: "Roboto-Bold.ttf", size: 14)
        self.lblAddress.font = UIFont(name: "Roboto-Bold.ttf", size: 14)
        
        
        let path = UIBezierPath(roundedRect: self.headerImageView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 9.0, height: 9.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.headerImageView.layer.mask = maskLayer
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
