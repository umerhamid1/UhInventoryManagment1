//
//  LoginViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/2/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
      

        // Do any additional setup after loading the view.
   
    
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.navigationController?.setNavigationBarHidden(true, animated: animated)
      }
      
      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
      }
    
    @IBAction func testing(_ sender: Any) {
        loginButton.isEnabled = false
        self.view.makeToastActivity(.center)
        
        
        if let email = emailTextField.text , let password = passwordTextField.text{
            
            
            Login.loginOb.login(email: email, password: password) { (error) in
                
                if error != ""{
                    self.view.hideToastActivity()
                    GeneralFunctions.gF.showMessage(title: "Error", msg: error!, on: self)
                    self.loginButton.isEnabled = true
                   
                }else{
                    self.view.hideToastActivity()
                    
                    GeneralFunctions.gF.showMessage(title: "SuccessFull", msg: "Login Sucessful", on: self)
                
                    self.performSegue(withIdentifier: "login", sender: self)
                    self.loginButton.isEnabled = true
                }
            }
            
        }
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "login"{
//            
//        }
//    }
    
}
