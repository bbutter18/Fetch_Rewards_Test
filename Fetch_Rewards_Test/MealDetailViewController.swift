//
//  MealDetailView.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/23/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit



class MealDetailViewController: UIViewController {
    
    var mealID: String = ""
    
    private var arrayOfIngredients: [String] = []
    private var arrayOfMeasurements: [String] = []
    private var stringOfInstructions: String = ""
    private var mealName: String = ""
    
    private var finalIngredients: [String] = []
    private var finalMeasurements: [String] = []
    
    //MARK: - UI Properties
    
    private let mealTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: 40)
        label.adjustsFontSizeToFitWidth = true 
        return label
    }()
    
    private let measurementLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial-BoldMT", size: 15)
        return label
    }()
    
    private let instructionsTextView: UITextView = {
        let textView = UITextView()
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isSelectable = false
        return textView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
 
        [mealTitleLabel, measurementLabel, instructionsTextView].forEach { view.addSubview($0) }
        view.backgroundColor = .white

        layoutLabelConstraints()
        
        fetchMealDetails(with: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)")
        
    }
    
    //MARK: - JSON Fetch Code
    fileprivate func fetchJSON(with url: String, completion: @escaping (Result<MealItems, Error>) -> Void) {
        
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //success
            do {
                let mealDetails = try JSONDecoder().decode(MealItems.self, from: data!)
                completion(.success(mealDetails))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
        
    }
    
    fileprivate func fetchMealDetails(with url: String) {
        
        fetchJSON(with: url) { (result) in
            
            switch result {
            case .success(let meal):
                print("success")
                
                for mealItems in meal.meals {
                    
                    for objects in mealItems.items {
                        self.arrayOfIngredients.append(objects.ingredient)
                        self.arrayOfMeasurements.append(objects.measure)
                    }
                    
                    if let name = mealItems.name, let instructions = mealItems.instructions {
                        self.mealName = name
                        self.stringOfInstructions = instructions
                    }
                    
                    self.finalIngredients = self.arrayOfIngredients.compactMap({ $0 }).filter({ !$0.isEmpty })
                    self.finalMeasurements = self.arrayOfMeasurements.compactMap({ $0 }).filter({ $0 != " " })
                }
                
                DispatchQueue.main.async {
                    self.setupLabels(title: self.mealName, measurements: self.finalMeasurements, ingredients: self.finalIngredients, instructions: self.stringOfInstructions)
                }
                
            case .failure(let error):
                print("Failed to fetch meal items:", error)
            }
        }
    }
    
    
    fileprivate func setupLabels(title: String, measurements: [String], ingredients: [String], instructions: String) {
        var string = ""
        self.mealTitleLabel.text = title
        
        for (e1, e2) in zip(measurements, ingredients) {
            string += "\(e1) - \(e2) \n"
        }
        
        self.measurementLabel.text = string
        self.instructionsTextView.text = instructions
    }
}


extension MealDetailViewController {
    
    private func layoutLabelConstraints() {
        
        mealTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 70))
        
        measurementLabel.anchor(top: mealTitleLabel.bottomAnchor, leading: mealTitleLabel.leadingAnchor, bottom: nil, trailing: mealTitleLabel.trailingAnchor, padding: .init(top: 20, left: 50, bottom: 0, right: 30), size: .init(width: 0, height: 0))
        
        instructionsTextView.anchor(top: measurementLabel.bottomAnchor, leading: mealTitleLabel.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: mealTitleLabel.trailingAnchor, padding: .init(top: 20, left: 30, bottom: 20, right: 30))
    }
}
