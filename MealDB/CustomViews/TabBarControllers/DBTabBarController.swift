//
//  DBTabBarController.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import UIKit

class DBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createDessertMealNC(), createFavoritesNC()]
    }
    
    func createDessertMealNC() -> UINavigationController {
        let dessertMealVC = MealVC(category: "Dessert")
        dessertMealVC.title = "Dessert Meals"
        dessertMealVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        return UINavigationController(rootViewController: dessertMealVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorite Recipes"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }

}
