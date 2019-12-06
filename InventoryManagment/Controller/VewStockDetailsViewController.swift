//
//  VewStockDetailsViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class VewStockDetailsViewController: UIViewController {

    var stock:product!
   

       
       @IBOutlet weak var productName: UILabel!
       
       @IBOutlet weak var saveBtn: UIButton!
       @IBOutlet weak var manufacturer: UITextField!
       @IBOutlet weak var descriptions: UITextView!
       @IBOutlet weak var quantity: UITextField!
       
       @IBOutlet weak var amount: UITextField!
       @IBOutlet weak var date: UITextField!
       
       let datePicker = UIDatePicker()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.loadUI()
           self.addBoarder()
           self.addImageToTextView(textField: self.date, img: UIImage(named: "pullDown")!)
         
           self.showDatePicker()
       }
       
       func addBoarder(){
           let myColor = UIColor.black
           self.descriptions.layer.borderColor = myColor.cgColor
           self.descriptions.layer.borderWidth = 1.0
       }
       
       func  addImageToTextView(textField: UITextField, img: UIImage){
           let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
           imageView.image = img
           textField.rightView = imageView
           textField.rightViewMode = .always
       }
       
       private func loadUI(){
           self.manufacturer.text = self.stock.manufacture
           self.productName.text = self.stock.name
           self.quantity.text = String(self.stock.quantity!)
           self.descriptions.text = self.stock.descriptionField
           self.amount.text = String(self.stock.amount!)
           self.date.text = self.stock.date
       }
       @IBAction func EditProduct(_ sender: Any) {
        
        self.view.makeToastActivity(.center)
          
           self.saveBtn.isEnabled = false
           if let name = self.productName.text, let manufacturer = self.manufacturer.text, let _description = self.descriptions.text, let amount = self.amount.text, let quantity = self.quantity.text, let date = self.date.text{
               let editProductObj = editProduct(name: name, manufacture: manufacturer, description: _description, amount: Int(amount)!, quantity: Int(quantity)!, date: date, pid:self.stock.id!)
            editProductObj._editProduct(email : staticLinkers.currentUser.email! , password:  staticLinkers.currentUser.password!, completionHandler: { (error,message)  in
                   DispatchQueue.main.async {
                      
                    self.view.hideToastActivity()
                       self.saveBtn.isEnabled = true
                       if error != ""{
                          
                        GeneralFunctions.gF.showMessage(title: "Alert", msg: error!, on: self)
                       }else{
                           let alert = UIAlertController(title: "Successful", message: message, preferredStyle: UIAlertController.Style.alert)
                           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                               self.navigationController?.popViewController(animated: true)
                           }))
                           self.present(alert, animated: true, completion: nil)
                       }
                   }
               })
           }else{
               
            self.view.hideToastActivity()
               self.saveBtn.isEnabled = true
              
             GeneralFunctions.gF.showMessage(title: "Alert", msg: "please enter all fields", on: self)
           }
       }
   }
   extension VewStockDetailsViewController{
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
           
           date.inputAccessoryView = toolbar
           date.inputView = datePicker
           
       }
       
       @objc private func donedatePicker(){
           
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           date.text = formatter.string(from: datePicker.date)
           self.view.endEditing(true)
       }
       
       @objc private func cancelDatePicker(){
           self.view.endEditing(true)
       }
   }

