//
//  ViewController.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/20/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    private var arrayOfModelData: [Category] = []
    private var filteredJSONModels: [Category] = []
    private var searchedMealNumber: String = ""
    private let urlAddress = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    lazy var dataSource: CategoryTableViewDataSource = {
        return CategoryTableViewDataSource(data: [])
    }()
    
    fileprivate func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = dataSource
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "The Meal DB"
        view.backgroundColor = .white
        
        setupTableView()
        searchBar.delegate = self
        searchBar.placeholder = "search meal number...53050"

        fetchCategories(with: urlAddress)
        
    }
    
    //MARK: - JSON Fetch Code
    fileprivate func fetchJSON(with url: String, completion: @escaping (Result<Categories, Error>) -> Void) {
        
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //success
            do {
                let categories = try JSONDecoder().decode(Categories.self, from: data!)
                completion(.success(categories))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
        
    }
    
    fileprivate func fetchCategories(with url: String) {
        
        fetchJSON(with: url) { (result) in
            
            switch result {
            case .success(let cats):
                print("success")
                self.filteredJSONModels = cats.categories.compactMap( { Category(name: $0.name)} )
                
                for object in self.filteredJSONModels {
                    self.arrayOfModelData.append(object)
                }
                
                DispatchQueue.main.async {
                    self.dataSource.updateData(self.arrayOfModelData)
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                //INSERT UIALERT
                print("Failed to fetch categories:", error)
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeals" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! MealListController
                guard let categoryName = self.arrayOfModelData[indexPath.row].name else { return }
                controller.categorySelection = categoryName
            }
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text is changing")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let mealNumberSearched = searchBar.text {
            self.searchedMealNumber = mealNumberSearched
            let controller = MealDetailViewController()
            controller.mealID = mealNumberSearched
            navigationController?.pushViewController(controller, animated: true)
            
        }
        
    }
    
    
    
}
