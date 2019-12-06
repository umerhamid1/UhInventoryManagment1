//
//  ViewStoreViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class ViewStoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var viewStoreTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    //private var loginObj = login(email: (staticLinker.currentUser?.email)!, password: (staticLinker.currentUser?.password)!)
    var refreshControl = UIRefreshControl()
    var storeData:[store]!
    let viewStoreObj = viewStore()
    private var msg = "Loading..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStoreTableView.layoutMargins = UIEdgeInsets.zero
        viewStoreTableView.separatorInset = UIEdgeInsets.zero
        self.slideMenu()
        self._loadData()
        viewStoreTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(_loadData), for: .valueChanged)
    }
    
    @objc private func _loadData(){
        self.viewStoreObj.getStores(email : staticLinkers.currentUser.email! , password: staticLinkers.currentUser.password!, completionHandler: { (error,_data)  in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                if let err = error{
                    print(err)
                    self.msg = err
                    self.storeData = nil
                    self.viewStoreTableView.reloadData()
                }else{
                    if _data!.isEmpty{
                        self.msg = "No products found"
                        self.storeData.removeAll()
                        self.viewStoreTableView.reloadData()
                    }else{
                        self.prepareData(data: _data!)
                        self.viewStoreTableView.reloadData()
                    }
                }
            }
        })
    }
    
}
extension ViewStoreViewController{
    
    func prepareData(data:[[String:Any]]){
        var temp = [store]()
        for i in data{
            let jsonData = try! JSONSerialization.data(withJSONObject: i, options: JSONSerialization.WritingOptions.prettyPrinted)
            let decoder = JSONDecoder()
            do
            {
                temp.append(try decoder.decode(store.self, from: jsonData))
            }
            catch{
                print(error.localizedDescription)
            }
        }
        self.storeData = temp
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 94
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell") as! StoreTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.storeName.text = self.storeData[indexPath.row].storeName
        cell.StoreLocation.text = self.storeData[indexPath.row].location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
        if self.storeData != nil {
            self.viewStoreTableView.tableFooterView = UIView()
            numOfSection = 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.viewStoreTableView.bounds.size.width, height: self.viewStoreTableView.bounds.size.height))
            noDataLabel.text = msg
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.viewStoreTableView.tableFooterView = noDataLabel
            
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

