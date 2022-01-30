//
//  MealCategory.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import Foundation

struct MealCategory: Decodable, Hashable, Comparable {
    
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
    
    static func < (lhs: MealCategory, rhs: MealCategory) -> Bool {
        lhs.strCategory < rhs.strCategory
    }
}

struct MealCategoryResponse: Decodable {
    let categories: [MealCategory]
}


