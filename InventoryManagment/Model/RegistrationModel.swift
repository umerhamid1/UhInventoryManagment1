//
//  RegistrationModel.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/1/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation
import Alamofire

public class RegistrationModel {
    
    var User:user?
    static var rM = RegistrationModel()
    
    
    private init(){
        
    }
    
    func registration(email : String , password : String , name : String , controller : UIViewController ,role : Bool, completion : @escaping (_ response : String)->Void){
        
        validation(email: email, password: password, name: name) { (msg) in
            if msg == ""{
                
                self.signUp(email: email, name: name, password: password, role: role) { (error) in
                    if error != "" {
                        //completion(error!)
                        GeneralFunctions.gF.showMessage(title: "Error", msg: error!, on: controller)
                        return
                    }else{
                        completion(error!)
                    }
                }
                
            }else{
               
                completion(msg)
            }
        }
        
    }
    
    func signUp(email : String , name : String , password : String ,role : Bool,completion: @escaping (_ UserData: String?) -> ()){
           Alamofire.request(staticLinkers.link.signUp, method: .post, parameters: ["email":email, "name":name, "password":password, "Role":role], encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in
               if let error = response.error{
                   let err = error.localizedDescription
                   completion(err)
               }else{
                   let temp = try! response.result.value as! [String:Any]
                   let err =  temp["error"] as! String
                   if err != ""{
                       completion(err)
                   }else{
                       let data = temp["data"] as! [String:Any]
                       staticLinkers.token = (data["token"] as! String)
                       var userData = data["user"] as! [String:Any]
                       userData["password"] = password
                       let jsonData = try! JSONSerialization.data(withJSONObject: userData, options: JSONSerialization.WritingOptions.prettyPrinted)
                       let decoder = JSONDecoder()
                       do
                       {
                           self.User = try decoder.decode(user.self, from: jsonData)
                           staticLinkers.currentUser = self.User
                       }
                       catch
                       {
                           completion(error.localizedDescription)
                       }
                       completion("")
                   }
               }
           })
       }
    
    
    func validation(email : String , password : String , name : String , completion : @escaping (_ error : String)-> Void){
        if GeneralFunctions.gF.isValidEmailAddress(emailAddressString: email) == false{
            completion("Email is Invalid")
        }else if GeneralFunctions.gF.isValidPassword(value: password) == false{
            completion("Password is Invalid")
        }else if  GeneralFunctions.gF.isValidName(value: name) == false {
            completion("Name only Contain Cheracters")
        }else{
            completion("")
        }
    }
}
