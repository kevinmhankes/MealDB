//
//  DBError.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import Foundation

enum DBError: String, Error {
    case invalidURL = "Unable to complete your request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case unableToFavorite = "There was an error trying to favorite this meal. Please try again."
    case alreadyInFavorites = "You've already favorited this meal."
}
