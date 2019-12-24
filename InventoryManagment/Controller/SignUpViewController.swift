//
//  SignUpViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/1/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//
import Alamofire
import UIKit
import SwiftyJSON
import Toast_Swift

class SignUpViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var emailTextField: textFieldDesign!
    
    @IBOutlet weak var nameTextField: textFieldDesign!
    
    @IBOutlet weak var passwordTextField: textFieldDesign!
    
    @IBOutlet weak var pickerText: UIPickerView!
    
    
    let pickerViewData=["True","False"]
    var role:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
      }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backButtonisPrssed(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
        
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonisPressed(_ sender: Any) {
        self.view.makeToastActivity(.center)
        print("button is pressed")
        
        if let email = emailTextField.text , let password = passwordTextField.text , let name = nameTextField.text{
            
            
            RegistrationModel.rM.registration(email: email, password: password, name: name, controller: self, role: role) { (response) in
                self.view.hideToastActivity()
                if response != ""{
                    
                    
                    
                    GeneralFunctions.gF.showMessage(title: "Error", msg: response, on: self)
                   // self.loginButton.isEnabled = true
                }else{
                   // self.view.hideToastActivity()
             //   GeneralFunctions.gF.showMessage(title: "SuccessFull", msg: "Registration is completed", on: self)
                self.performSegue(withIdentifier: "signUp", sender: self)
                   
                   
                   
                  // self.loginButton.isEnabled = true
                }
                //  print("Registraion response : \(response)")
                
                
                
                
            }
        }else{
            self.view.hideToastActivity()
            GeneralFunctions.gF.showMessage(title: "Error", msg: "Enter complete Data", on: self)
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


extension SignUpViewController{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerViewData[row] == "True"{
            role = true
        }else{
            role = false
        }
        return
    }
}
