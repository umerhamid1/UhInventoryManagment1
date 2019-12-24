//
//  AddStoreViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit
import Toast_Swift

class AddStoreViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var storeNameTextField: textFieldDesign!
    
    
    @IBOutlet weak var locationTextField: textFieldDesign!
    
    
    @IBOutlet weak var saveButton: ButtonDesign!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenu()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        saveButton.isEnabled = false
        self.view.makeToastActivity(.center)
        if let name = self.storeNameTextField.text, let location = self.locationTextField.text{
            
            StoreAdd.sd.addStore(storeName: name, storeLocation: location,
            completionHandler: { (error,message)  in
                DispatchQueue.main.async {
                    
                    self.saveButton.isEnabled = true
                    self.view.hideToastActivity()
                    if error != nil{
                        GeneralFunctions.gF.showMessage(title: "Alert", msg: error!, on: self)
                        
                    }else{
                        
                        
                        self.storeNameTextField.text = ""
                        
                        self.locationTextField.text = ""
                        
                        GeneralFunctions.gF.askToAddMoreData(title: "SucessFull", msg: "Store Sucessfully Added , do you want to add more Data", controller: self, navigation: self.navigationController!)
                       
                        
                       
                        
                       
                        
                    }
                }
            })
        }else{
            
            self.view.hideToastActivity()
            
            self.saveButton.isEnabled = true
            
            GeneralFunctions.gF.showMessage(title: "Alert", msg: "Data can't be empty", on: self)
        }
        
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
