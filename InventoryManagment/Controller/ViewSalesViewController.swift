

import UIKit

class ViewSalesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var viewSalesTableView: UITableView!
    
    var salesData:[salesData]!
    private var msg = "Loading..."
    var refreshControl = UIRefreshControl()
    var viewSalesObj = getSalesRecord()
    //  private var loginObj = login(email: (staticLinker.currentUser?.email)!, password: (staticLinker.currentUser?.password)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slideMenu()
        self._loadData()
        viewSalesTableView.layoutMargins = UIEdgeInsets.zero
        viewSalesTableView.separatorInset = UIEdgeInsets.zero
        viewSalesTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(_loadData), for: .valueChanged)
    }
    
    
    
    
    
    
    @objc private func _loadData(){
        self.viewSalesObj.getSalesRecordData(
            completionHandler: { (error,_data)  in
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    if let err = error{
                        print(err)
                        self.msg = err
                        self.salesData = nil
                        self.viewSalesTableView.reloadData()
                    }else{
                        if _data == nil{
                            self.msg = "No products found"
                            // self.salesData.removeAll()
                            self.viewSalesTableView.reloadData()
                        }else{
                            self.salesData = _data
                            self.viewSalesTableView.reloadData()
                        }
                    }
                }
        })
    }
}

extension ViewSalesViewController{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.salesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salesRecordCell") as! SalesDetailTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        

        
        cell.productName.text = self.salesData[indexPath.row].productName ?? "NotFound"
        cell.storeName.text = self.salesData[indexPath.row].storeName ?? "NotFound"
        cell.storeLocation.text = self.salesData[indexPath.row].storeLocation ?? "NotFound"
        cell.quantity.text = "\(self.salesData[indexPath.row].sale?.quantity)"
        cell.saleVolume.text = "nil"//self.salesData[indexPath.row].productName
        cell.date.text = "nil"//self.salesData[indexPath.row].sale?.saleDate 
         return cell
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
        if self.salesData != nil {
            self.viewSalesTableView.tableFooterView = UIView()
            numOfSection = 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.viewSalesTableView.bounds.size.width, height: self.viewSalesTableView.bounds.size.height))
            noDataLabel.text = msg
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.viewSalesTableView.tableFooterView = noDataLabel
            
        }
        return numOfSection
    }
    
    private func slideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 280
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }
    
}

