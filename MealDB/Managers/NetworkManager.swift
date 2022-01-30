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
    
    private let categoriesURL = baseURL + "categories.php"
    
    private init() {}
    
    func getCategories() async throws -> [MealCategory] {
        guard let url = URL(string: categoriesURL) else {
            throw DBError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoded = try decoder.decode(MealCategoryResponse.self, from: data)
            print(decoded.categories)
            return try decoder.decode(MealCategoryResponse.self, from: data).categories
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
