//
//  MealVC.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import UIKit

class MealVC: DBDataLoadingVC {
    
    let tableView = UITableView()
    
    var category: String!
    var meals: [Meal] = []
    
    init(category: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        title = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getMeals(category: category)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func getMeals(category: String) {
        showLoadingView()
        
        Task {
            do {
                let meals = try await NetworkManager.shared.getMeals(for: category)
                updateUI(with: meals)
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
    
    func updateUI(with meals: [Meal]) {
        self.meals = meals
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MealVC: UITableViewDataSource, UITableViewDelegate {
    
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
        let destVC = MealDetailVC(mealID: meal.idMeal, mealName: meal.strMeal)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}
