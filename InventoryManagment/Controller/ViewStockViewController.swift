
//

import UIKit
import Alamofire

class ViewStockViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var viewStockTableView: UITableView!
    
  
    
    var boxView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        //self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStockTableView.layoutMargins = UIEdgeInsets.zero
        viewStockTableView.separatorInset = UIEdgeInsets.zero
        self.slideMenu()
       
        viewStockTableView.rowHeight = UITableView.automaticDimension
        viewStockTableView.estimatedRowHeight = 108
      
    }
    
  
}

extension ViewStockViewController{
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//data.count
    }
    
    
 
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! ViewStockTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.name.text =  "" //data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
      
        return 1
    }
    
    private func slideMenu(){
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 280
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }
 
    private func _loader() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.gray
        textLabel.text = "Deleting..."
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }
}
