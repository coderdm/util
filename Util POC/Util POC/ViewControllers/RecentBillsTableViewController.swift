//
//  RecentBillsTableViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 25/04/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class RecentBillsTableViewController: UITableViewController {
    var expandedArray:Array<Bool> = [false,false]
    var bills : [Bill] = [Bill]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .utlSunflowerYellow
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        let billOne = Bill(billType: "Electricity Services",totalConsumption: "634 Kwh",billAmount: "$63",year:"May 2017")
        let billTwo = Bill(billType: "Gas Services",totalConsumption: "1.576 Thm",billAmount: "$107", year:"April 2017")
        bills.append(billOne)
        bills.append(billTwo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.visibleViewController?.navigationItem.addNavigationView(withImage: "recentBillIcon", title: "Recent Bills")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.expandedArray[section] == true ? bills.count + 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellBillDetails", for: indexPath) as! BillTableViewCell
            cell.serviceTypeLabel.text = bills[indexPath.row].billType
            cell.billPeriodLabel.text = bills[indexPath.row].year
            cell.consumptionLabel.text = bills[indexPath.row].totalConsumption
            cell.billAmountLabel.text = bills[indexPath.row].billAmount
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentBillsTotalAmount", for: indexPath)
            return cell
        }
        
    }
 

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1{
            return 364
        }else{
            return 163
        }
        
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.expandedArray[sender.view!.tag] =  self.expandedArray[sender.view!.tag] == true ? false : true
        //if let cellView = sender.view as? BillRowAddressTableViewCell {
            
            //cellView.lblExpand.text =  self.expandedArray[sender.view!.tag] == true ? "-" : "+"
           // cellView.expandableImage.image =  self.expandedArray[sender.view!.tag] == true ? UIImage(named: "minusButton") : UIImage(named: "plusButton")
        //}
        self.tableView.reloadData()
        self.tableView.reloadSectionIndexTitles()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
