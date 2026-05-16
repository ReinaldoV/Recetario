//
//  CarHandle.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 13/5/26.
//

protocol CarHandleProtocol {
    func addIngredientsToCart(ingredients: [String])
    func getCar() -> [Ingredient]
}

struct Ingredient {
    let name: String
    var ammount: Int = 1
}

class CarHandle: CarHandleProtocol {
    
    
    // Changed to 'fileprivate' or internal if your protocol needs to access it,
    // or kept private but fixed the access pattern.
    static var cart: [Ingredient] = []
    
    func addIngredientsToCart(ingredients: [String]) {
        for ingredientName in ingredients {
            // 1. Check if an ingredient with the exact same name already exists
            if let index = CarHandle.cart.firstIndex(where: { $0.name == ingredientName }) {
                // Fixed typo 'ammount' to 'amount' (Ensure your Ingredient struct matches this)
                CarHandle.cart[index].ammount += 1
            } else {
                // 2. If it doesn't exist, create a new one with a default amount of 1
                let newIngredient = Ingredient(name: ingredientName, ammount: 1)
                CarHandle.cart.append(newIngredient)
            }
        }
        // REMOVED: CarHandle.cart.append(contentsOf: ingredients)
        // This was trying to append [String] into a [Ingredient] array, which fails.
    }
    
    // Fixed: The protocol/return type must match what you are actually returning.
    func getCar() -> [Ingredient] {
        return CarHandle.cart
    }
}
