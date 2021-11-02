//
//  AddCoffeeOrderViewModel.swift
//  CoffeeOrder
//
//  Created by Jerome Pullen Jr. on 11/1/21.
//
struct AddCoffeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeSize.allCases.map { $0.rawValue.capitalized }
    }
}
