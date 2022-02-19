//
//  PersistenceManager.swift
//  MealDB
//
//  Created by Kevin Hankes on 2/18/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let meals = "meals" }
    
    static func updateWith(meal: Meal, actionType: PersistenceActionType, completed: @escaping (DBError?) -> Void) {
        retrieveMeals { result in
            switch result {
            case .success(var meals):
                switch actionType {
                case .add:
                    guard !meals.contains(meal) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    meals.append(meal)
                    
                case .remove:
                    meals.removeAll { $0.idMeal == meal.idMeal }
                }
                
                completed(save(meals: meals))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveMeals(completed: @escaping (Result<[Meal], DBError>) -> Void) {
        guard let mealsData = defaults.object(forKey: Keys.meals) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let meals = try decoder.decode([Meal].self, from: mealsData)
            completed(.success(meals))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(meals: [Meal]) -> DBError? {
        do {
            let encoder = JSONEncoder()
            let encodedMeals = try encoder.encode(meals)
            defaults.set(encodedMeals, forKey: Keys.meals)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
