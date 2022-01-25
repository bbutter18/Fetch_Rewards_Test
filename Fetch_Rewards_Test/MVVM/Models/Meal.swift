//
//  Meals.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/20/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation


struct Meals: Decodable {
    let meals: [Meal]
    
}

struct Meal: Decodable {
    let name: String?
    let id: String?
 
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case id = "idMeal"
    }
    
}
