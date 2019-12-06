//
//  Product.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/6/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//


import Foundation

struct product : Codable {
    
    let amount : Int?
    let date : String?
    let descriptionField : String?
    let id : Int?
    let manufacture : String?
    let name : String?
    let quantity : Int?
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case date = "date"
        case descriptionField = "description"
        case id = "id"
        case manufacture = "manufacture"
        case name = "name"
        case quantity = "quantity"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        manufacture = try values.decodeIfPresent(String.self, forKey: .manufacture)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }
    
}
