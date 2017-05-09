//
//  ReportIssueViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 04/05/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class ReportIssueViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var btnReportIssue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        if (appDelegate.issue.isEmpty) {
            let issue = Issue(issueType: "Streetlight Outage", dateReported: "05/05/2017", issueAddress: "3275NW 24thStreet Rd, Miami", status: "Report Submitted", lat: "25.7617", lon: "80.1918")
            appDelegate.issue.append(issue)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.visibleViewController?.navigationItem.addNavigationView(withImage: "telemarketer", title: "Complaints")
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "Map",
            style: .done,
            target: self,
            action: #selector(rightButtonAction)
        )
        
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func rightButtonAction(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showMapView", sender: self)
    }
    
    @IBAction func btnReportIssueTapped(_ sender: Any) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (appDelegate.issue.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PowerOutageCell") as? PowerOutageTableViewCell {
            let issueObj = appDelegate.issue[indexPath.row]
            cell.lblHeaderOutage.text = issueObj.issueType
            cell.lblHeaderDate.text = issueObj.dateReported
            cell.lblSubOutageType.text = issueObj.issueType
            cell.lblAddress.text = issueObj.issueAddress
            return cell
        }
        
        
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "PowerOutageCell", for: indexPath)
        return emptyCell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
