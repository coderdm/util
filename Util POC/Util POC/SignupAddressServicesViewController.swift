//
//  SignupAddressServicesViewController.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/11/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class SignupAddressServicesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var servicesTableView: UITableView!
    
    var expandedArray:Array<Bool> = [false,false]

    var services : [Service] = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.servicesTableView.tableFooterView = UIView(frame: .zero)
        

        let serviceOne = Service(serviceType: "Gas Services", ecomonyType: "Economy 100 plan", validTillDate: "Valid till : 12/23/2020")
        let serviceTwo = Service(serviceType: "Electricity Services", ecomonyType: "Economy 100 plan", validTillDate: "Valid till : 12/28/2020")
        services.append(serviceOne)
        services.append(serviceTwo)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - Tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.expandedArray[section] == true ? services.count : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBillRowAddress") as! BillRowAddressTableViewCell
        cell.tag = section
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        cell.addGestureRecognizer(tapGesture)
        cell.expandableImage.image =  self.expandedArray[cell.tag] == true ? UIImage(named: "minusButton") : UIImage(named: "plusButton")
        
        if section == 0 {
            cell.addressLabel.text = "3275 NW 24th Street Rd"
        }else{
            cell.addressLabel.text = "7865 SW 8th Street Rd"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignupServicesCell", for: indexPath) as! SignupServicesTableViewCell
        let path:UIBezierPath
        
        if indexPath.row == 0 {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 9.0, height: 9.0))
            
            cell.serviceImageView.image = UIImage.init(named: "gas")
            
        }else{
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 9.0, height: 9.0))
            
//            let view = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//            let gradient = CAGradientLayer()
//            
//            gradient.frame = view.bounds
//            gradient.colors = [UIColor.init(colorLiteralRed: 56/255, green: 62/255, blue: 80/255, alpha: 1.0).cgColor, UIColor.init(colorLiteralRed: 91/255, green: 102/255, blue: 140/255, alpha: 1.0).cgColor]
//            
//            cell.serviceImageView.image = UIImage.init(named: "lightBulbOn")
//            cell.layer.insertSublayer(gradient, at: 0)
        
        }
        
        cell.backgroundColor = UIColor.init(colorLiteralRed: 56/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        cell.serviceTypeLabel.text = services[indexPath.row].serviceType
        cell.economyTypeLabel.text = services[indexPath.row].ecomonyType
        cell.validTillLabel.text = services[indexPath.row].validTillDate
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
        
        return cell

    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.expandedArray[sender.view!.tag] =  self.expandedArray[sender.view!.tag] == true ? false : true
       
        self.servicesTableView.reloadData()
        self.servicesTableView.reloadSectionIndexTitles()
    }

}
