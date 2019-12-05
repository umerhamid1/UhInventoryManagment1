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
                    
                    self.performSegue(withIdentifier: "login", sender: self)
                    self.view.hideToastActivity()
                    
                    
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
