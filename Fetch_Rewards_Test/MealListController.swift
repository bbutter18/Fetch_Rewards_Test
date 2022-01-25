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
    fileprivate func fetchJSON(with url: String, completion: @escaping (Result<Meals, Error>) -> Void) {
        
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //success
            do {
                let meals = try JSONDecoder().decode(Meals.self, from: data!)
                completion(.success(meals))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
        
    }
    
    fileprivate func fetchMeals(with url: String) {
        
        fetchJSON(with: url) { (result) in
            
            switch result {
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
