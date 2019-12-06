//
//  AddSalesDetailViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 11/30/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class AddSalesDetailViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

     @IBOutlet weak var menuButton: UIBarButtonItem!
      @IBOutlet weak var storeTxt: textFieldDesign!
      @IBOutlet weak var productTxt: textFieldDesign!
      @IBOutlet weak var salesDateTxt: textFieldDesign!
      @IBOutlet weak var quantityTxt: textFieldDesign!
      @IBOutlet weak var unitPriceTxt: textFieldDesign!
     
      @IBOutlet weak var addSalesBtn: ButtonDesign!
      
      let datePicker = UIDatePicker()
      var productPickerData:[productsDataObject] = [productsDataObject(productName: "Loading...", productId: -1)]
      var storePickerData:[storesDataObject] = [storesDataObject(storeName: "Loading...", storeId: -1)]
      var currentTextField = UITextField()
      var pickerView = UIPickerView()
      let getAllPickerDataObj = getStoreProducts()
      var storeIndex = -1
      var productIndex = -1
      
     // private var loginObj = login(email: staticLinker.currentUser.email!, password: staticLinker.currentUser.password!)
      var salesObj:addInventorySales!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          addImageToTextView(textField: self.storeTxt, img: UIImage(named: "pullDown")!)
          addImageToTextView(textField: self.productTxt, img: UIImage(named: "pullDown")!)
          addImageToTextView(textField: self.salesDateTxt, img: UIImage(named: "pullDown")!)
        
        productTxt.delegate = self
        storeTxt.delegate = self
        
          self.getStore_ProductData()
         // loader.isHidden = true
         // loader.hidesWhenStopped = true
          self.slideMenu()
          self.showDatePicker()
      }
      
      @IBAction func addSales(_ sender: Any) {

        self.view.makeToastActivity(.center)
          self.addSalesBtn.isEnabled = false
          if let _ = self.storeTxt.text, let _ = self.productTxt.text, let date = self.salesDateTxt.text, let quantity = self.quantityTxt.text, let price = self.unitPriceTxt.text{
              self.salesObj = addInventorySales(pid: self.productIndex, sid: self.storeIndex, salesDate: date, quantity: Int(quantity)!, stockSold: Int(price)!)
            self.salesObj.addSales(email : staticLinkers.currentUser.email!,password: staticLinkers.currentUser.password!, completionHandler: { (error,message)  in
                  DispatchQueue.main.async {
                      
                    self.view.hideToastActivity()
                      self.addSalesBtn.isEnabled = true
                      if error != ""{
//                          let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
//                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                          self.present(alert, animated: true, completion: nil)
                        
                        GeneralFunctions.gF.showMessage(title: "Alert", msg: error!, on: self)
                      }else{
                        
                        GeneralFunctions.gF.showMessage(title: "Alert", msg: message!, on: self)
//                          let alert = UIAlertController(title: "Successful", message: message, preferredStyle: UIAlertController.Style.alert)
//                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                          self.present(alert, animated: true, completion: nil)
                      }
                  }
              })
          }else{
             // self.loader.stopAnimating()
              self.addSalesBtn.isEnabled = true
            self.view.hideToastActivity()

            GeneralFunctions.gF.showMessage(title: "Alert", msg: "Fill all textField ", on: self)
      
          }
      }
      
      
      private func getStore_ProductData(){
          self.menuButton.isEnabled = false
          self.getAllPickerDataObj.getAllStoresData(completionHandler: {(error,storeData) in
              if error != nil{
                  let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
              }else{
                  self.storePickerData = storeData!
                  self.pickerView.reloadAllComponents()
                  self.getAllPickerDataObj.getAllProductsData(completionHandler: {(error,productData) in
                      if error != nil{
                          let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                          alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                          self.present(alert, animated: true, completion: nil)
                      }else{
                          self.productPickerData = productData!
                          self.pickerView.reloadAllComponents()
                          self.menuButton.isEnabled = true
                      }
                  })
              }
          })
      }
      
  }

  extension AddSalesDetailViewController{
      
      func  addImageToTextView(textField: UITextField, img: UIImage){
          let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
          imageView.image = img
          textField.rightView = imageView
          textField.rightViewMode = .always
      }
      
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          if currentTextField == storeTxt{
            print("store Count : \(self.storePickerData.count)")
              return self.storePickerData.count
          }else if currentTextField == productTxt{
              return self.productPickerData.count
          }else{
              return 0
          }
      }
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          if currentTextField == storeTxt{
              return self.storePickerData[row].storeName
          }else if currentTextField == productTxt{
              return self.productPickerData[row].productName
          }else{
              return ""
          }
      }
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          if currentTextField == storeTxt{
              self.storeIndex = self.storePickerData[row].storeId
              self.currentTextField.text = self.storePickerData[row].storeName
          }else if currentTextField == productTxt{
              self.productIndex = self.productPickerData[row].productId
              self.currentTextField.text = self.productPickerData[row].productName
          }
      }
      
      func textFieldDidBeginEditing(_ textField: UITextField) {
          self.pickerView.delegate = self
          self.pickerView.dataSource = self
          
          self.pickerView.selectRow(0, inComponent: 0, animated: true)
          
          self.currentTextField = textField
          
          self.pickerView.reloadAllComponents()
          
          self.currentTextField.inputView = pickerView
      }
      
      private func showDatePicker(){
          //Formate Date
          self.datePicker.datePickerMode = .date
          
          //ToolBar
          let toolbar = UIToolbar();
          toolbar.sizeToFit()
          let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
          let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
          let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
          
          toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
          
          salesDateTxt.inputAccessoryView = toolbar
          salesDateTxt.inputView = datePicker
          
      }
      
      @objc private func donedatePicker(){
          
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          salesDateTxt.text = formatter.string(from: datePicker.date)
          self.view.endEditing(true)
      }
      
      @objc private func cancelPicker(){
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

