//
//  StoreAdd.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/6/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//



import Foundation
import Alamofire

class StoreAdd{
   
    
    static var sd = StoreAdd()
   private init(){
      
    }
    
    func addStore(//loginObj:login,
        
        storeName : String,
        storeLocation : String,
        
                  completionHandler: @escaping (_ error: String?, _ message:String?) -> ()
    ){
        Login.loginOb.login(email: staticLinkers.currentUser.email!, password: staticLinkers.currentUser.password!, completionHandler: { (error) in
            DispatchQueue.main.async {
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    self.addStoreExt(storeName : storeName ,storeLocation : storeLocation ,completionHandler: {(error,message) in
                        completionHandler(error,message)
                    })
                }
            }
        }
    )}
    
    private func addStoreExt(storeName : String,
    storeLocation : String,completionHandler: @escaping (_ error: String?, _ message:String?) -> ()){
        Alamofire.request(staticLinkers.link.addStores,
                          method: .post, parameters: ["storeName":storeName,"location":storeLocation],
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type":"application/json","token":staticLinkers.token]
        ).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                completionHandler(err,nil)
            }else{
                let temp = try! response.result.value as! [String:Any]
                let err = temp["error"] as! String
                
                if  err != ""{
                   // let err = error as! String
                    completionHandler(err,nil)
                }else{
                    let msg = temp["message"] as! String
                    completionHandler(nil,msg)
                }
            }
        })
    }

}
