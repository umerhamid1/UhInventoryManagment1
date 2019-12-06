//
//  AddInventorySales.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/6/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//



import Foundation
import Alamofire

class addInventorySales{
    var salesDetailData:[String:Any]
    
    init(pid:Int, sid:Int, salesDate:String, quantity:Int, stockSold:Int) {
        self.salesDetailData = ["pid":pid,"sid":sid,"saleDate":salesDate,"quantity":quantity,"stockSold":stockSold]
    }
    
    func addSales(email : String, password : String, completionHandler: @escaping (_ error: String?, _ message:String?) -> ()){
        Login.loginOb.login(email : email , password : password , completionHandler: { (error) in
            DispatchQueue.main.async {
                if error != ""{
                    completionHandler(error,nil)
                }else{
                    self.addSalesExt( completionHandler: {(error,message) in
                        completionHandler(error,message)
                    })
                }
            }
        }
    )}
    
    private func addSalesExt( completionHandler: @escaping (_ error: String?, _ message:String?) -> ()){
        Alamofire.request(staticLinkers.link.addSales, method: .post,
                   parameters: self.salesDetailData,
                   encoding: JSONEncoding.default, headers: ["Content-Type":"application/json","token":staticLinkers.token]).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                let err = error.localizedDescription
                completionHandler(err,nil)
            }else{
                let temp = try! response.result.value as! [String:Any]
                 let error = temp["error"] as! String
                if error != nil{
                   
                    completionHandler(error,nil)
                }else{
                    let msg = temp["message"] as! String
                    completionHandler(nil,msg)
                }
            }
        })
    }
    
}
