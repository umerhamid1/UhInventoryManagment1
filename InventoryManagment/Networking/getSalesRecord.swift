//
//  getSalesRecord.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/5/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//


import Foundation
import Alamofire

class getSalesRecord{
    
    func getSalesRecordData(//loginObj:login,
        
        completionHandler: @escaping (_ error: String?, _ data:[salesData]?) -> ()){
        
        Login.loginOb.login(email: staticLinkers.currentUser.email!, password: staticLinkers.currentUser.password!) { (error) in
            DispatchQueue.main.async {
                if error != ""{
                    completionHandler(error, nil)
                }else{
                    self.getSalesRecordDataExt { (error, data) in
                        completionHandler(error, data)
                    }
                }
            }
        }
        
        
        
    }
    
    private func getSalesRecordDataExt(completionHandler: @escaping (_ error: String?, _ data:[salesData]?) -> ()){
        Alamofire.request(staticLinkers.link.getSales,
                          method: .get,
                          //parameters:nil,
                        //  encoding: JSONEncoding.default,
                          headers: ["token" :  staticLinkers.token] //["Content-Type":"application/json","token":staticLinkers.token]
            
        ).responseJSON(completionHandler: {(response) in
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
                    if dta.isEmpty{
                        completionHandler(nil,nil)
                    }else{
                        var saleDta = [salesData]()
                        for i in dta{
                            let jsonData = try! JSONSerialization.data(withJSONObject: i, options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                saleDta.append(try decoder.decode(salesData.self, from: jsonData))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        completionHandler(nil,saleDta)
                    }
                }
            }
        })
    }
}
