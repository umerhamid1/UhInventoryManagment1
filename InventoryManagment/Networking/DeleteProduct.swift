//
//  DeleteProduct.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/6/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//


import Foundation
import Alamofire

class DeleteProduct{
    
    func delStock(stockId:Int, email : String , password : String, completionHandler: @escaping (_ error: String?, _ msg:String?) -> ()){
        Login.loginOb.login(email : email , password : password , completionHandler: { (error) in
            DispatchQueue.main.async {
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    self.delStockExt(stockId: stockId,completionHandler: {(error,msg) in
                        completionHandler(error,msg)
                    })
                    
                }
            }
        }
    )}
    
    private func delStockExt(stockId:Int, completionHandler: @escaping (_ error: String?, _ data:String?) -> ()){
        Alamofire.request(staticLinkers.link.deleteProduct, method: .delete, parameters: ["pid":stockId], encoding: JSONEncoding.default /*JSONEncoding.default*/, headers: ["Content-Type":"application/json","token":staticLinkers.token]).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                print(stockId)
                completionHandler(err,nil)
            }else{
                let temp = try! response.result.value as! [String:Any]
                let error = temp["error"] as! String
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    let msg = temp["message"] as! String
                    completionHandler(nil,msg)
                }
            }
        })
    }
}
