import Foundation

protocol FavoriteHandlerProtocol {
    var updateView: (() -> Void)? { get set }
    func getFavorites() -> [Meal]
    func saveFavorite(_ meal: Meal)
    func deleteFavorite(_ meal: Meal) // Fixed spelling
    func toggleFavorite(_ meal: Meal)
    func getValueOf(_ meal: Meal) -> Bool
}

class FavoriteHandler: FavoriteHandlerProtocol {
    private let defaults = UserDefaults.standard
    private let favoritesKey = "favoritesKey"
    var updateView: (() -> Void)?
    
    func getFavorites() -> [Meal] {
        // 1. Get the Data from UserDefaults
        guard let data = defaults.data(forKey: favoritesKey) else { return [] }
        
        // 2. Decode the Data back into an array of Meals
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Meal].self, from: data)
        } catch {
            print("Error decoding favorites: \(error)")
            return []
        }
    }
    
    func saveFavorite(_ meal: Meal) {
        var favorites = getFavorites()
        // Prevent duplicates
        guard !favorites.contains(where: { $0.idMeal == meal.idMeal }) else { return }
        
        favorites.append(meal)
        saveToDefaults(favorites)
    }
    
    func deleteFavorite(_ meal: Meal) {
        var favorites = getFavorites()
        favorites.removeAll(where: { $0.idMeal == meal.idMeal })
        saveToDefaults(favorites)
    }
    
    func toggleFavorite(_ meal: Meal) {
        if getFavorites().contains(where: { $0.idMeal == meal.idMeal }) {
            deleteFavorite(meal)
        } else {
            saveFavorite(meal)
        }
        self.updateView?()
    }
    
    // Helper method to handle encoding
    private func saveToDefaults(_ favorites: [Meal]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            defaults.set(data, forKey: favoritesKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }
    
    func getValueOf(_ meal: Meal) -> Bool {
        return getFavorites().contains(where: { $0.idMeal == meal.idMeal })
    }
}
