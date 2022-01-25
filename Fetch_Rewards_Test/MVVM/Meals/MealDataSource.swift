//
//  DataSource.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/22/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit

class MealTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var data: [Meal]
    
    init(data: [Meal]) {
        self.data = data
        super.init()
    }
    
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.reuseIdentifier, for: indexPath) as! MealCell
        
        let modelObject = object(at: indexPath)
        let viewModel = MealViewModel(model: modelObject)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    //MARK: - Helper Methods
    
    func update(_ object: Meal, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [Meal]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> Meal {
        return data[indexPath.row]
    }
    
}


