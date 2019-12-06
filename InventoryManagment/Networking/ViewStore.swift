//
//  ViewStore.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/6/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//



import Foundation
import  Alamofire

class viewStore{
    
    func getStores(email : String, password : String, completionHandler: @escaping (_ error: String?, _ data:[[String:Any]]?) -> ()){
        Login.loginOb.login(email : email , password : password , completionHandler: { (error) in
            DispatchQueue.main.async {
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    self.getStoresExt(completionHandler: {(error,data) in
                        completionHandler(error,data)
                    })
                }
            }
        }
    )}
    
    
    
    private func getStoresExt(completionHandler: @escaping (_ error: String?, _ data:[[String:Any]]?) -> ()){
        Alamofire.request(staticLinkers.link.getStores, method: .get, parameters:nil, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json","token":staticLinkers.token]).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                completionHandler(err,nil)
            }else{
                let temp = try! response.result.value as! [String:Any]
                let error = temp["error"] as! String
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    let dta = temp["data"] as! [[String:Any]]
                    completionHandler(nil,dta)
                }
            }
        })
    }
    
}
