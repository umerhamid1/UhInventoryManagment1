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
    override func viewDidLoad() {
        super.viewDidLoad()

        viewStoreTableView.delegate = self
        viewStoreTableView.dataSource = self
        slideMenu()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
     

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell") as! StoreTableViewCell
         cell.layoutMargins = UIEdgeInsets.zero
         cell.storeName.text = "" //self.storeData[indexPath.row].storeName
         cell.StoreLocation.text = "" //self.storeData[indexPath.row].location
         return cell
     }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
           return 94
       }
    
    private func slideMenu(){
          if revealViewController() != nil{
              menuButton.target = revealViewController()
              menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
              revealViewController()?.rearViewRevealWidth = 280
              
              view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
          }
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
