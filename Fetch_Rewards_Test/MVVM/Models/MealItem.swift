//
//  MealItem.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/23/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit

struct MealItems: Decodable {
    let meals: [SingleMeal]
    
}

struct SingleMeal: Decodable {
    let name: String?
    let instructions: String?
    let items: [Item]
    
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
    }
}

extension SingleMeal {
    
    struct Item: Decodable {
        let ingredient: String
        let measure: String
    }
}

extension SingleMeal {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let itemDictionary = try container.decode([String: String?].self)
        var index = 1
        var items = [Item]()
        while let ingredient = itemDictionary["strIngredient\(index)"] as? String, let measure = itemDictionary["strMeasure\(index)"] as? String, !measure.isEmpty {
                items.append(Item(ingredient: ingredient, measure: measure))
                index += 1
            }
        
        let container2 = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container2.decode(String.self, forKey: .name)
        self.instructions = try container2.decode(String.self, forKey: .instructions)
        self.items = items
    }
}
