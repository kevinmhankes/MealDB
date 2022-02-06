//
//  MealDetailVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealDetailVC: DBDataLoadingVC {
    
    var mealName: String!
    var mealID: String!
    
    var mealDetail: MealDetail?
    
    init(mealID: String, mealName: String) {
        super.init(nibName: nil, bundle: nil)
        self.mealID = mealID
        title = mealName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(mealID: mealID)
    }
    
    func getRecipe(mealID: String) {
        showLoadingView()
        
        Task {
            do {
                let mealDetail = try await NetworkManager.shared.getMealDetail(for: mealID)
                updateUI(with: mealDetail)
                print(mealDetail)
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
    
    func updateUI(with mealDetail: MealDetail) {
        self.mealDetail = mealDetail
    }
    
}
