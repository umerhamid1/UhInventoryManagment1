//
//  SalesDetailTableViewCell.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class SalesDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeLocation: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var saleVolume: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
