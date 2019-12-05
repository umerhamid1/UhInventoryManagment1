//
//  sales.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/5/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation
struct sales : Codable {
    
    let id : Int?
    let productID : Int?
    let quantity : Int?
    let saleDate : String?
    let stockSold : Int?
    let storeID : Int?
    let totalAmount : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productID = "productID"
        case quantity = "quantity"
        case saleDate = "saleDate"
        case stockSold = "stockSold"
        case storeID = "storeID"
        case totalAmount = "totalAmount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        productID = try values.decodeIfPresent(Int.self, forKey: .productID)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        saleDate = try values.decodeIfPresent(String.self, forKey: .saleDate)
        stockSold = try values.decodeIfPresent(Int.self, forKey: .stockSold)
        storeID = try values.decodeIfPresent(Int.self, forKey: .storeID)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
    }
    
}

