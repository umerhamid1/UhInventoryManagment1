//
//  user.swift
//  InventoryManagment
//
//  Created by umer hamid on 12/4/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation


import Foundation

struct user : Codable {
    
    let email : String?
    let id : Int?
    let name : String?
    let password : String?
    let role : Bool?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case id = "id"
        case name = "name"
        case password = "password"
        case role = "Role"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        role = try values.decodeIfPresent(Bool.self, forKey: .role)
    }
    
}
