//
//  NetworkManager.swift
//  MealDB
//
//  Created by Kevin Hankes on 1/29/22.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private let mealsURL = baseURL + "filter.php?c="
    private let recipesURL = baseURL + "lookup.php?i="
    
    private init() {}
    
    func getMeals(for category: String) async throws -> [Meal] {
        guard let url = URL(string: "\(mealsURL)\(category)") else {
            throw DBError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try decoder.decode(MealResponse.self, from: data).meals.sorted()
        } catch {
            throw DBError.invalidData
        }
    }
    
    func getMealDetail(for mealID: String) async throws -> MealDetail {
        guard let url = URL(string: "\(recipesURL)\(mealID)") else {
            throw DBError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try decoder.decode(MealDetailResponse.self, from: data).meals.first!
        } catch {
            throw DBError.invalidData
        }
    }
    
    func downloadImage(fromURLString urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
