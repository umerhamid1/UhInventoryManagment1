//
//  AddProductViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slideMenu()
        // Do any additional setup after loading the view.
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
