//
//  CarHandle.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 13/5/26.
//

protocol CarHandleProtocol {
    func addIngredientsToCart(ingredients: [String])
    func getCar() -> [String]
}

class CarHandle: CarHandleProtocol {
    
    static private var cart: [String] = []
    
    func addIngredientsToCart(ingredients: [String]) {
        CarHandle.cart.append(contentsOf: ingredients)
    }
    
    func getCar() -> [String] {
        return CarHandle.cart
    }
}
