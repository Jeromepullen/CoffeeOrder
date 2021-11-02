//
//  Order.swift
//  CoffeeOrder
//
//  Created by Jerome Pullen Jr. on 11/1/21.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case capuccino, latte, espressino, cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case small, medium, large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeSize
}

extension Order {
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: AddCoffeOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
    }
}

extension Order {
    
    init?(_ vm: AddCoffeOrderViewModel) {
        guard let name = vm.name,
            let email = vm.email,
            let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
            let selectedSize = CoffeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}
