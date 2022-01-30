//
//  MealVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealVC: DBDataLoadingVC {
    
    var category: String!
    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getMeals(category: category)
    }
    
    func getMeals(category: String) {
        showLoadingView()
        
        Task {
            do {
                let meals = try await NetworkManager.shared.getMeals(for: category)
                print(meals)
                dismissLoadingView()
            } catch {
                if let dbError = error as? DBError {
                    presentDBAlert(title: "Something went wrong", message: dbError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                
                dismissLoadingView()
            }
        }
    }
}
