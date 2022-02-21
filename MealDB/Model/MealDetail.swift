//
//  MealDetail.swift
//  MealDB
//
//  Created by Kevin Hankes on 2/6/22.
//

import Foundation

struct MealDetail: Decodable {
    var idMeal: String
    var strMeal: String
    var strInstructions: String
    var strMealThumb: String
    var ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strInstructions
        case strMealThumb
        
        // Ingredient list...this should probably have been an array...
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        
        // Corresponding measurement list...this should also probably be an array
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        ingredients = []
        var ingredientList: [String] = []
        var measurementList: [String] = []
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        
        let ingredientKeys: [CodingKeys] = [.strIngredient1,
                                  .strIngredient2,
                                  .strIngredient3,
                                  .strIngredient4,
                                  .strIngredient5,
                                  .strIngredient6,
                                  .strIngredient7,
                                  .strIngredient8,
                                  .strIngredient9,
                                  .strIngredient10,
                                  .strIngredient11,
                                  .strIngredient12,
                                  .strIngredient13,
                                  .strIngredient14,
                                  .strIngredient15,
                                  .strIngredient16,
                                  .strIngredient17,
                                  .strIngredient18,
                                  .strIngredient19,
                                  .strIngredient20]
        
        let measurementKeys: [CodingKeys] = [.strMeasure1,
                                             .strMeasure2,
                                             .strMeasure3,
                                             .strMeasure4,
                                             .strMeasure5,
                                             .strMeasure6,
                                             .strMeasure7,
                                             .strMeasure8,
                                             .strMeasure9,
                                             .strMeasure10,
                                             .strMeasure11,
                                             .strMeasure12,
                                             .strMeasure13,
                                             .strMeasure14,
                                             .strMeasure15,
                                             .strMeasure16,
                                             .strMeasure17,
                                             .strMeasure18,
                                             .strMeasure19,
                                             .strMeasure20]
        
        for key in ingredientKeys {
            if let ingredient = try container.decodeIfPresent(String.self, forKey: key), !ingredient.isEmpty {
                ingredientList.append(ingredient)
            }
        }
        
        for key in measurementKeys {
            if let measurement = try container.decodeIfPresent(String.self, forKey: key), !measurement.isEmpty {
                measurementList.append(measurement)
            }
        }
        
        // assumption based on the idea that there can be more ingredients than measurements, but not more measurements than ingredients
        // alternative option would just be having the two lists in the MealDetail struct
        for i in 0..<ingredientList.count {
            var ingredient: Ingredient
            if i < measurementList.count {
                ingredient = Ingredient(ingredient: ingredientList[i], measurement: measurementList[i])
            } else {
                ingredient = Ingredient(ingredient: ingredientList[i], measurement: "")
            }
            ingredients.append(ingredient)
        }
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        // Remove carriage returns for string
        let unsanitizedInstructions = try container.decode(String.self, forKey: .strInstructions)
        strInstructions = unsanitizedInstructions.replacingOccurrences(of: "\r\n", with: "\n")
    }
    
}

extension MealDetail {
    func mealIngredientsToString() -> String {
        var ingredientString = ""
        for (index, ingredient) in self.ingredients.enumerated() {
            ingredientString.append("\(ingredient.ingredient)")
            if (!ingredient.measurement.isEmpty) {
                ingredientString.append(" \(ingredient.measurement)")
            }
            if index < self.ingredients.count - 1 {
                ingredientString.append(", ")
            }
        }
        return ingredientString
    }
}

struct MealDetailResponse: Decodable {
    var meals: [MealDetail]
}

struct Ingredient {
    var ingredient: String
    var measurement: String
}
