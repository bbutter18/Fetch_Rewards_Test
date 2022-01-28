//
//  APIClient.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/28/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit


struct APIClient {
    
    func fetchJSON<T: Decodable>(with url: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(response))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
        
    }
    
    
    
    
} //END
