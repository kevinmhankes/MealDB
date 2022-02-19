//
//  FavoritesListVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import UIKit

class FavoritesListVC: DBDataLoadingVC {
    
    let tableView = UITableView()
    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(MealCell.self, forCellReuseIdentifier: MealCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retrieveMeals { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let meals):
                self.updateUI(with: meals)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentDBAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
    func updateUI(with meals: [Meal]) {
        if meals.isEmpty {
            self.showEmptyStateView(with: "No meals favorited?\nAdd one on the meals screen!", in: self.view)
        } else {
            self.meals = meals
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
                view.bringSubviewToFront(tableView)
            }
        }
    }
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.reuseID) as! MealCell
        let meal = meals[indexPath.row]
        cell.set(meal: meal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        let destVC = MealDetailVC(mealID: meal.idMeal)
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(meal: meals[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.meals.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            DispatchQueue.main.async {
                self.presentDBAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
