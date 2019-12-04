//
//  SignUpViewController.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/1/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//
import Alamofire
import UIKit

class SignUpViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var emailTextField: textFieldDesign!
    
    @IBOutlet weak var nameTextField: textFieldDesign!
    
    @IBOutlet weak var passwordTextField: textFieldDesign!
    
    @IBOutlet weak var pickerText: UIPickerView!
    
    
    let pickerViewData=["True","False"]
    var role:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpButtonisPressed(_ sender: Any) {
        self.view.makeToastActivity(.center)
        print("button is pressed")
        
        if let email = emailTextField.text , let password = passwordTextField.text , let name = nameTextField.text{
            
            self.signUp { (response) in
                print("signup response : \(response)")
            }
            //            RegistrationModel.rM.registration(email: email, password: password, name: name, controller: self, role: role) { (response) in
            //
            //                if response != ""{
            //                    self.view.hideToastActivity()
            //                    GeneralFunctions.gF.showMessage(title: "Error", msg: response, on: self)
            //                }else{
            //
            //                    GeneralFunctions.gF.showMessage(title: "msg", msg: "Successful", on: self)
            //                     self.view.hideToastActivity()
            //                }
            //                     //  print("Registraion response : \(response)")
            //
            //                       //prepare(for: UIStoryboardSegue, sender: self)
            //
            //
            //                   }
        }else{
            self.view.hideToastActivity()
            GeneralFunctions.gF.showMessage(title: "Error", msg: "Enter complete Data", on: self)
        }
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
    
    
    
    var User:user?
    
    func signUp(completionHandler: @escaping (_ UserData: String?) -> ()){
        
        
        Alamofire.request(staticLinkers.link.signIn, method: .post, parameters: ["email":emailTextField.text!, "name": nameTextField.text!, "password": passwordTextField.text!, "role": true] , encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                completionHandler(err)
            }else{
                
                let temp = try! response.result.value as! [String : Any] //get() as! [String:Any]
                let err =  temp["error"] as! String
                if err != ""{
                    completionHandler(err)
                }else{
                    let data = temp["data"] as! [String:Any]
                    staticLinkers.token = (data["token"] as! String)
                    var userData = data["user"] as! [String:Any]
                    userData["password"] = ""
                    let jsonData = try! JSONSerialization.data(withJSONObject: userData, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoder = JSONDecoder()
                    do
                    {
                        self.User = try decoder.decode(user.self, from: jsonData)
                        staticLinkers.currentUser = self.User
                    }
                    catch
                    {
                        completionHandler(error.localizedDescription)
                    }
                    completionHandler("")
                }
                
            }
        })
        
        
        //        Alamofire.request(staticLinkers.link.signUp, method: .post, parameters: ["email":emailTextField.text!, "name": nameTextField.text!, "password": passwordTextField.text!, "role": true], encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in
        //               if let error = response.error{
        //                   let err = error.localizedDescription
        //                   completionHandler(err)
        //               }else{
        //                let temp = try! response.result.value as! [String : Any] //get() as! [String:Any]
        //                   let err =  temp["error"] as! String
        //                   if err != ""{
        //                       completionHandler(err)
        //                   }else{
        //                       let data = temp["data"] as! [String:Any]
        //                       staticLinkers.token = (data["token"] as! String)
        //                       var userData = data["user"] as! [String:Any]
        //                       userData["password"] = ""
        //                       let jsonData = try! JSONSerialization.data(withJSONObject: userData, options: JSONSerialization.WritingOptions.prettyPrinted)
        //                       let decoder = JSONDecoder()
        //                       do
        //                       {
        //                           self.User = try decoder.decode(user.self, from: jsonData)
        //                           staticLinkers.currentUser = self.User
        //                       }
        //                       catch
        //                       {
        //                           completionHandler(error.localizedDescription)
        //                       }
        //                       completionHandler("")
        //                   }
        //               }
        //           })
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
