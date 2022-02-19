//
//  MealInfo.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/30/22.
//

import Foundation

struct Meal: Codable, Hashable, Comparable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        lhs.strMeal < rhs.strMeal
    }
}

struct MealResponse: Decodable {
    var meals: [Meal]
}
