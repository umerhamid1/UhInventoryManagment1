//
//  EditProduct.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/6/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//



import Foundation
import Alamofire

class editProduct{
    var deletingProductData:[String:Any]

    init(name:String, manufacture:String, description:String, amount:Int, quantity:Int, date:String, pid:Int) { self.deletingProductData = ["name":name,"manufacture":manufacture,"description":description,"amount":amount,"quantity":quantity,"date":date,"pid":pid]
    }
    
    func _editProduct(email : String , password : String, completionHandler: @escaping (_ error: String?, _ message:String?) -> ()){
        Login.loginOb.login(email : email , password : password ,completionHandler: { (error) in
            DispatchQueue.main.async {
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    self.editProductExt( completionHandler: {(error,message) in
                        completionHandler(error,message)
                    })
                }
            }
        }
    )}
    
    private func editProductExt( completionHandler: @escaping (_ error: String?, _ message:String?) -> ()){
        Alamofire.request(staticLinkers.link.editProducts, method: .post, parameters: self.deletingProductData, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json","token":staticLinkers.token]).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                completionHandler(err,nil)
            }else{
                let temp = try! response.result.value as! [String:Any]
                if let error = temp["error"]{
                    let err = error as! String
                    completionHandler(err,nil)
                }else{
                    let msg = temp["message"] as! String
                    completionHandler(nil,msg)
                }
            }
        })
    }
    
}

