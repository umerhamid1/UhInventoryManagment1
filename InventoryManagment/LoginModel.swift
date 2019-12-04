//
//  LoginModel.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/4/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//
//Users/umerhamid/Desktop/Axiom App/bootCamp/UhInventoryManagment-master/InventoryManagment/Main.storyboard
import Foundation
import Alamofire

class Login{

    var User:user?
    
    static var loginOb = Login()
    private init(){
        
    }
    
    func login(email : String , password : String , completionHandler: @escaping (_ UserData: String?) -> ()){
        
    
        
        Alamofire.request(staticLinkers.link.signIn, method: .post, parameters: ["email":email,"password": password], encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                completionHandler(err)
            }else{
                
                let temp = try! response.result.value as! [String : Any]//.get() as! [String:Any]
                let err = temp["error"] as! String
                if err != ""{
                    completionHandler(err)
                }else{
                    let data = temp["data"] as! [String:Any]
                    
                    var userData = data["user"] as! [String:Any]
                    userData["password"] = password
                    staticLinkers.token = (data["token"] as! String)
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
    }
}
