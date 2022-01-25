//
//  CategoryDataSource.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/21/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit

class CategoryTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var data: [Category]
    
    init(data: [Category]) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
        
        let modelObject = object(at: indexPath)
        let viewModel = ViewModel(model: modelObject)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    //MARK: - Helper Methods
    
    func update(_ object: Category, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [Category]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> Category {
        return data[indexPath.row]
    }
    
}


