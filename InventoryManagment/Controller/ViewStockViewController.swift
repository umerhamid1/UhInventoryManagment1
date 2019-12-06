
//

import UIKit
import Alamofire

class ViewStockViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var viewStockTableView: UITableView!
    
    //private var loginObj = login(email: staticLinker.currentUser.email!, password: staticLinker.currentUser.password!)
    var refreshControl = UIRefreshControl()
    var data:[product]!
    private var msg = "Loading..."
    var productData:product!
    var getProductObj = GetProduct()
    
    var boxView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStockTableView.layoutMargins = UIEdgeInsets.zero
        viewStockTableView.separatorInset = UIEdgeInsets.zero
        self.slideMenu()
        self.loadData()
        viewStockTableView.rowHeight = UITableView.automaticDimension
        viewStockTableView.estimatedRowHeight = 108
        viewStockTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    @objc private func loadData(){
        self.getProductObj.getStock(email : staticLinkers.currentUser.email!, password: staticLinkers.currentUser.password!, completionHandler: { (error,_data)  in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                if let err = error{
                    self.msg = err
                    self.data = nil
                    self.viewStockTableView.reloadData()
                }else{
                    if _data!.isEmpty{
                        self.msg = "No products found"
                        self.data = nil
                        self.viewStockTableView.reloadData()
                    }else{
                        self.prepareData(data: _data!)
                        self.viewStockTableView.reloadData()
                    }
                }
            }
        })
    }
}

extension ViewStockViewController{
    
    func prepareData(data:[[String:Any]]){
        var temp = [product]()
        for i in data{
            let jsonData = try! JSONSerialization.data(withJSONObject: i, options: JSONSerialization.WritingOptions.prettyPrinted)
            let decoder = JSONDecoder()
            do
            {
                temp.append(try decoder.decode(product.self, from: jsonData))
            }
            catch{
                print(error.localizedDescription)
            }
        }
        self.data = temp
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.productData = data[indexPath.row]
        self.performSegue(withIdentifier: "productDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail"{
            let viewStockDetail = segue.destination as? VewStockDetailsViewController
            viewStockDetail?.stock = self.productData
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! ViewStockTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.name.text = data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:  UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete \(String(describing: self.data[indexPath.row].name!))?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                self.deleteStock(stockId: self.data[indexPath.row].id!, index: indexPath.row)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
        if self.data != nil {
            self.viewStockTableView.tableFooterView = UIView()
            numOfSection = 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.viewStockTableView.bounds.size.width, height: self.viewStockTableView.bounds.size.height))
            noDataLabel.text = msg
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.viewStockTableView.tableFooterView = noDataLabel
            
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
    private func deleteStock(stockId:Int, index:Int){
        let delStock = DeleteProduct()
        self._loader()
        delStock.delStock(stockId: stockId, email : staticLinkers.currentUser.email!, password:  staticLinkers.currentUser.password! , completionHandler: { (error,msg)  in
            DispatchQueue.main.async {
                if let err = error{
                    let alert = UIAlertController(title: "Alert", message: err, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.boxView.removeFromSuperview()
                }else{
                    self.data.remove(at: index)
                    if self.data.count == 0{
                        self.msg = "No products found"
                        self.boxView.removeFromSuperview()
                    }
                    self.viewStockTableView.reloadData()
                    let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.boxView.removeFromSuperview()
                }
            }
        })
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
