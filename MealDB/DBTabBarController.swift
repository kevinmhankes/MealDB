//
//  DBTabBarController.swift
//  MealsDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import UIKit

class DBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createMealCategoryNC(), createFavoritesNC()]
    }
    
    func createMealCategoryNC() -> UINavigationController {
        let searchCategoryVC = MealCategoryVC()
        searchCategoryVC.title = "Meal Categories"
        searchCategoryVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchCategoryVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorite Recipes"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }

}
