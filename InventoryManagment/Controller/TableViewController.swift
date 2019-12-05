//
//  TableViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.userName.text =  staticLinkers.currentUser?.name
    }


}
