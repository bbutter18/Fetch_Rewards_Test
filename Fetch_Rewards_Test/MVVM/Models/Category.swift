//
//  Categories.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/20/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation

struct Categories: Decodable {
    let categories: [Category]
    
}

struct Category: Decodable {
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
    
    
  
}



