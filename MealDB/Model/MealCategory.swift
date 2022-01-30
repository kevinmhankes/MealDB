//
//  MealCategory.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import Foundation

struct MealCategory: Decodable, Hashable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}

struct MealCategoryResponse: Decodable {
    let categories: [MealCategory]
}
