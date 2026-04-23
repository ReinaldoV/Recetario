//
//  ApiService.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 22/4/26.
//

import Foundation

class ApiService {
    static func fetchMeals() async -> [Meal] {
        var meals: [Meal] = []
        for key in ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","k","r","s","t","u","v","w","x","y","z"] {
            let mealsWithLetter = await fechMeal(key: key)
            meals.append(contentsOf: mealsWithLetter)
        }
        return meals
    }
    
    static private func fechMeal(key: String) async -> [Meal] {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?f=\(key)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return []
        }
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Ensure we got a 200 OK response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Server error")
                return []
            }
            
            // Decode the JSON data
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode(MealResponse.self, from: data)
            
            // Print results
            if let meals = mealResponse.meals {
                return meals
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return []
    }
}

// To run this in a non-async context (like a Button click or viewDidLoad):
// Task {
//    await fetchMeals()
// }
