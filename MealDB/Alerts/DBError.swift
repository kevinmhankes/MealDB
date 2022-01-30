//
//  DBError.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import Foundation

enum DBError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
