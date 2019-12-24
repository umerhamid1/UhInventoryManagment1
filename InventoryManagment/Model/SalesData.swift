//
//  SalesData.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/5/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation

struct salesData : Codable {
    
    let productName : String?
    let sale : sales?
    let storeLocation : String?
    let storeName : String?
    
    enum CodingKeys: String, CodingKey {
        case productName = "productName"
        case sale = "sale"
        case storeLocation = "storeLocation"
        case storeName = "storeName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        sale = try sales(from: decoder)
        storeLocation = try values.decodeIfPresent(String.self, forKey: .storeLocation)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
    }
}


// here is new classes start


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]
    let error, message: String
}

// MARK: - Datum
struct Datum: Codable {
    let productName: String
    let sale: Sale
    let storeLocation, storeName: String
}

// MARK: - Sale
struct Sale: Codable {
    let id, productID, quantity: Int
    let saleDate: String
    let stockSold, storeID, totalAmount: Int
}

struct salesTest{
    
    let productName : String = ""
    let sale : sales
    let storeLocation : String = ""
    let storeName : String = ""
    
      
}


