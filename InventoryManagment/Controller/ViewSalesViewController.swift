

import UIKit

class ViewSalesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var viewSalesTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenu()
       // self._loadData()
        viewSalesTableView.layoutMargins = UIEdgeInsets.zero
        viewSalesTableView.separatorInset = UIEdgeInsets.zero
    
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
    

extension ViewSalesViewController{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //self.salesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salesRecordCell") as! SalesDetailTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.productName.text =  "" //self.salesData[indexPath.row].productName
        cell.storeName.text = "" //self.salesData[indexPath.row].storeName
        cell.productName.text = "" //self.salesData[indexPath.row].productName
        cell.productName.text = "" //self.salesData[indexPath.row].productName
        cell.productName.text = "" //self.salesData[indexPath.row].productName
        cell.productName.text = "" //self.salesData[indexPath.row].productName
       // cell.line
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
      
        return 1
    }
    
  
    
}
