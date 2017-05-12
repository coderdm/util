//
//  BillDetailViewController.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/11/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class BillDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,BillAddressDetailsDelegate {
    var expandedArray:Array<Bool> = [false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillAddressDetailsCell", for: indexPath) as! BillAddressDetailslTableViewCell
                
            cell.delegate = self
            
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 9.0, height: 9.0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            cell.layer.mask = maskLayer
            
            return cell
            
        }else if indexPath.row == 1{
           
            cell = tableView.dequeueReusableCell(withIdentifier: "ConsumptionCell", for: indexPath)
        }else if indexPath.row == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "PlanDetailsCell", for: indexPath)
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: "RecentBillsTotalAmount", for: indexPath)
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 9.0, height: 9.0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            cell.layer.mask = maskLayer
        }
        
        
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 356
            
        }else if indexPath.row == 1{
            return 384
            
        }else if indexPath.row == 2{
            return 185
        }else {
            return 163
        }

    }
    
    // MARK: - BillAddressDetailsCell delegate methods
    func expandIconTapped(){
        
    }
    
}
