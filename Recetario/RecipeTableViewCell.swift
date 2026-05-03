//
//  RecipeTableViewCell.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 2/5/26.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // Use '!' because this will be set immediately after the cell is created
    var meal: Meal!
    
    let favoritesHandler: FavoriteHandlerProtocol = FavoriteHandler()
    
    // This is called when loading from Storyboard/XIB
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateView()
    }

    @IBAction func favoritePressed(_ sender: Any) {
        // Now you can safely use 'meal'
        favoritesHandler.toggleFavorite(meal)
        updateView()
    }
    
    func updateView() {
            nameLabel.text = meal.strMeal
            
            // Check if the current meal is in favorites to set the icon
            let favorites = favoritesHandler.getFavorites()
            let isFavorite = favorites.contains(where: { $0.idMeal == meal.idMeal })
            
            let iconName = isFavorite ? "heart.fill" : "heart"
            favoriteButton.setImage(UIImage(systemName: iconName), for: .normal)
        }
}
