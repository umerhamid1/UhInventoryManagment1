//
//  GeneralFunctions.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/1/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation

public class GeneralFunctions{
    
    static var gF = GeneralFunctions()
    
    private init(){
        
    }

    
    // here alert view Controller
    
    func showMessage(title: String, msg: String, `on` controller: UIViewController) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    // end alert view controller
    
    
    
    
    // here is validation start
    
    
    
    
    
    
    // password validation
    func isValidPassword(value: String) -> Bool {
        let PASSWORD_REGEX = "(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{6,15})$"
        // let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PASSWORD_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
    
    
    
    //email validation
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isValidName(value: String) -> Bool {
        let PASSWORD_REGEX = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        // let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", PASSWORD_REGEX)
        let result =  nameTest.evaluate(with: value)
        return result
    }
    
    
    // end validation
    
    
}
