//
//  ReportIssueViewController.swift
//  Util POC
//
//  Created by Sridhar, Swaroop (US - Bengaluru) on 04/05/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit

class ReportIssueViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,OutageHistoryServiceDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var issuesTableView: UITableView!
    @IBOutlet weak var btnReportIssue: UIButton!
    
    var filteredArray = [Outage]()
    var loadingViewController = LoadingViewController()
    
    let searchViewHeightConstantExtended = 52.0
    let searchViewHeightConstantCollapsed = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
//        if (appDelegate.issue.isEmpty) {
//            let issue1 = Issue(issueType: "Streetlight Outage", dateReported: "05/05/2017", issueAddress: "3275NW 24thStreet Rd, Tampa", status: "Report Submitted", lat: "25.7617", lon: "80.1918" , referenceNumber : "2356879627")
//            appDelegate.issue.append(issue1)
//            
//            let issue2 = Issue(issueType: "Power Outage", dateReported: "05/05/2017", issueAddress: "3275NW 24thStreet Rd, Tampa", status: "Report Submitted", lat: "25.7617", lon: "80.1918" , referenceNumber : "7625467892")
//            appDelegate.issue.append(issue2)
//        }
//        
//        self.filteredArray = appDelegate.issue
    
        self.setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.tap(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        
//        loadingViewController.view.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        let storyboard = UIStoryboard.init(name: "Generic", bundle: nil)
        loadingViewController  = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController

        
        self.getOutage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.visibleViewController?.navigationItem.addNavigationView(withImage: "telemarketer", title: "Issues")
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "Map",
            style: .done,
            target: self,
            action: #selector(rightButtonAction)
        )
        
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = rightButtonItem
        
        self.resetTableDataAndReload()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = nil
    }

    
    //MARK: - View methods
    
    func resetTableDataAndReload(){
        self.filteredArray = appDelegate.issue
        self.issuesTableView.reloadData()
    }
    
    func setupViews(){
        self.btnReportIssue.layer.borderColor = UIColor.red.cgColor
        self.btnReportIssue.layer.borderWidth = 1.0
        self.btnReportIssue.layer.cornerRadius = 15.0
        
        self.searchViewHeightConstraint.constant = CGFloat(searchViewHeightConstantCollapsed)
        
    }

    func updateStatusView(viewCell: PowerOutageTableViewCell , status:String){
        
        switch status {
        case "Report Submitted":
            viewCell.statusFirstImageView.image = UIImage(named: "submit")
            viewCell.statusSecondImageView.image = UIImage(named: "progress")
            viewCell.statusThirdImageView.image = UIImage(named: "progress")
            viewCell.inProgressLabel.text = "Under review"
            break
        case "Resolved" :
            viewCell.statusFirstImageView.image = UIImage(named: "progress")
            viewCell.statusSecondImageView.image = UIImage(named: "progress")
            viewCell.statusThirdImageView.image = UIImage(named: "submit")
            viewCell.inProgressLabel.text = "Under review"
            break
        default:
            viewCell.statusFirstImageView.image = UIImage(named: "progress")
            viewCell.statusSecondImageView.image = UIImage(named: "submit")
            viewCell.statusThirdImageView.image = UIImage(named: "progress")
            viewCell.inProgressLabel.text = status
        }
    }
    
    func updateAddress(viewCell: PowerOutageTableViewCell, issueObject : Outage){
        
        let reverseGeocodeService = ReverseGeocode()
        reverseGeocodeService.reverseGeocodeFromLatitudeLongitude(latitude: issueObject.latitude!, longitude: issueObject.longitude!) { (address : String) in
            
            DispatchQueue.main.async {
                issueObject.address = address
                viewCell.lblAddress.text = address
            }
            
        }
        
    }
    
    // MARK: - TableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.filteredArray.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PowerOutageCell") as? PowerOutageTableViewCell {
            let issueObj = self.filteredArray[indexPath.row]
            cell.lblHeaderOutage.text = issueObj.outageType
            cell.lblHeaderDate.text = issueObj.issueRaisedDateString
            cell.lblReferenceNumber.text = issueObj.referenceNumber;
            if (issueObj.address != nil) {
                cell.lblAddress.text = issueObj.address
            }else{
                self.updateAddress(viewCell: cell, issueObject: issueObj)
            }
            
            
            self.updateStatusView(viewCell: cell, status: issueObj.issueStatus)
            return cell
        }
        
        
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "PowerOutageCell", for: indexPath)
        return emptyCell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 332.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 30.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 2.0
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Roboto-Italic", size: 13)
        header.textLabel?.textColor = UIColor.init(colorLiteralRed: 72.0/225.0, green: 78.0/225.0, blue: 99.0/225.0, alpha: 1.0)
        view.tintColor = UIColor.white
        
        if section == 0 {
            header.textLabel?.text = "     This Week"
        }else {
            header.textLabel?.text = "     This Month"
        }
    }
    
    // MARK: - Action methods
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.searchViewHeightConstraint.constant = CGFloat(searchViewHeightConstantExtended)
    }
    
    @IBAction func btnReportIssueTapped(_ sender: Any) {
        
    }
    
    @IBAction func searchViewCancelButtonTapped(_ sender: Any) {
        self.searchViewHeightConstraint.constant = CGFloat(searchViewHeightConstantCollapsed)
        self.searchTextField.resignFirstResponder()
        self.resetTableDataAndReload()
    }
    
    func rightButtonAction(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showMapView", sender: self)
    }

    
   //MARK: - TextField Methods
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        self.filterContent(forSearchText: sender.text!, scope: "")
    }
    
    //MARK: - Utility Methods
    func filterContent(forSearchText searchText: String, scope: String) {
        if searchText.isEmpty{
            self.resetTableDataAndReload()
        }else{
            self.filteredArray = appDelegate.issue.filter { NSPredicate(format: "self.referenceNumber beginswith[c] %@ OR self.referenceNumber beginswith[cd] %@", searchText).evaluate(with: $0) }
            self.issuesTableView.reloadData()
        }
        
        
    }

    //MARK: - tap gesture Methods
    func tap(gesture: UITapGestureRecognizer) {
        self.searchTextField.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - network service Methods
    func getOutage(){
        
       self.loadingViewController.show()
        let outageHistoryService = OutageHistoryService()
        outageHistoryService.delegate = self
        outageHistoryService.getOutageHistory()
    }
    
    //MARK: - OutageHistoryServiceDelegate methods
    func outageHistory(outages : [Outage]){
        if outages != nil{
            self.filteredArray = outages
            appDelegate.issue = outages
            DispatchQueue.main.async {
                self.issuesTableView.reloadData()
                self.loadingViewController.stop()
            }
            
        }
        
    }

}
