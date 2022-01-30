//
//  MealDetailVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealDetailVC: UIViewController {
    
    var mealName: String!
    var mealID: String!
    
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
        print(mealID!)
    }
    
}
