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
    var ingredientList: [String]
    var measurementList: [String]
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strInstructions
        case strMealThumb
        
        // Ingredient list...why isn't this an array to begin with?
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
        
        // Corresponding measurement list...why isn't this also in an array to begin with?
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
        ingredientList = []
        measurementList = []
        
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
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        // Remove carriage returns for string
        let unsanitizedInstructions = try container.decode(String.self, forKey: .strInstructions)
        strInstructions = unsanitizedInstructions.replacingOccurrences(of: "\r\n", with: "\n")
        
    }
    
}

struct MealDetailResponse: Decodable {
    var meals: [MealDetail]
}
