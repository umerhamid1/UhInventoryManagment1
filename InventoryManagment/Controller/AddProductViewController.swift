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
    
    @IBOutlet weak var productName: textFieldDesign!
    @IBOutlet weak var manufacturer: textFieldDesign!
    @IBOutlet weak var descript: textFieldDesign!
    @IBOutlet weak var amount: textFieldDesign!
    @IBOutlet weak var quantity: textFieldDesign!
    @IBOutlet weak var txtDatePicker: textFieldDesign!
    @IBOutlet weak var addProductBtn: ButtonDesign!
    
    
    let datePicker = UIDatePicker()
    
    
    private var addProductObj:AddProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenu()
        self.addImageToTextView(textField: self.txtDatePicker, img: UIImage(named: "pullDown")!)
        
        self.showDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func  addImageToTextView(textField: UITextField, img: UIImage){
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        imageView.image = img
        textField.rightView = imageView
        textField.rightViewMode = .always
    }
    
    @IBAction func AddProductBtn(_ sender: Any) {
        
        self.view.makeToastActivity(.center)
        self.addProductBtn.isEnabled = false
        if let name = self.productName.text, let manufacturer = self.manufacturer.text, let _description = self.descript.text, let amount = self.amount.text, let quantity = self.quantity.text, let date = self.txtDatePicker.text{
            
            self.addProductObj = AddProduct(name: name, manufacture: manufacturer, description: _description, amount: Int(amount)!, quantity: Int(quantity)!, date: date)
            
            self.addProductObj.addProduct(email : staticLinkers.currentUser.email! , password : staticLinkers.currentUser.password!, completionHandler: { (error,message)  in
                DispatchQueue.main.async {
                    
                    self.view.hideToastActivity()
                    self.addProductBtn.isEnabled = true
                    if error != nil{
                        
                        
                        GeneralFunctions.gF.showMessage(title: "Alert", msg: error!, on: self)
                    }else{
                        
                        self.productName.text = ""
                        self.manufacturer.text = ""
                        self.descript.text = ""
                        self.amount.text = ""
                        self.quantity.text = ""
                        self.txtDatePicker.text = ""
                        
                        GeneralFunctions.gF.askToAddMoreData(title: "SucessFull", msg: "Product is  Added , do you want to add more Product", controller: self, navigation: self.navigationController!)
                    }
                }
            })
        }else{
            
            self.view.hideToastActivity()
            self.addProductBtn.isEnabled = true
            GeneralFunctions.gF.showMessage(title: "Alert", msg: "Please fill all Fileds", on: self)
            
        }
    }
}


extension AddProductViewController{
    private func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc private func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func cancelDatePicker(){
        self.view.endEditing(true)
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

