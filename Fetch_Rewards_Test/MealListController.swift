//
//  MealListController.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/22/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit

class MealListController: UIViewController {
    
    private var arrayOfModelData: [Meal] = []
    private var filteredJSONModels: [Meal] = []
    var categorySelection: String = ""
    let apiClient = APIClient()

    
    @IBOutlet weak var mealTableView: UITableView!
    
    lazy var mealListDataSource: MealTableViewDataSource = {
        MealTableViewDataSource(data: [])
    }()
    
    
    fileprivate func setupTableView() {
        self.mealTableView.delegate = self
        self.mealTableView.dataSource = mealListDataSource
    }
 
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTableView()
        
        fetchMeals(with: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categorySelection)")
      
    }
    
    //MARK: - JSON Fetch Code
    fileprivate func fetchMeals(with url: String) {
        
        self.apiClient.fetchJSON(with: url) { (response: Result<Meals, Error>) in 
            
            switch response {
            case .success(let jsonMeals):
                print("success")
                self.filteredJSONModels = jsonMeals.meals.compactMap( { Meal(name: $0.name, id: $0.id)} )
                
                for object in self.filteredJSONModels {
                    self.arrayOfModelData.append(object)
                }
                
                DispatchQueue.main.async {
                    self.mealListDataSource.updateData(self.arrayOfModelData)
                    self.mealTableView.reloadData()
                }
                
            case .failure(let error):
                //INSERT UIALERT
                print("Failed to fetch meals:", error)
            }
        }
    }
    
    
    
    
}


extension MealListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a specific meal")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealDetails" {
            if let indexPath = self.mealTableView.indexPathForSelectedRow {
                let controller = segue.destination as! MealDetailViewController
                guard let mealIdentificationNumber = self.arrayOfModelData[indexPath.row].id else { return }
                controller.mealID = mealIdentificationNumber
            }
        }
    }
    
}
