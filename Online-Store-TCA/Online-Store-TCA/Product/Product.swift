//
//  Product.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import Foundation

struct Product: Equatable, Identifiable {
    let id: Int
    let title: String
    let price: Double // update to currency
    let description: String
    let category: String // update to enum
    let imageString: String

    // add rating later
}

extension Product {
    static var sample: [Product] {
        [
            Product(
                id: 1,
                title: "Wireless Earbuds",
                price: 49.99,
                description: "High-quality wireless earbuds with noise cancellation.",
                category: ".electronics",
                imageString: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
            ),
            Product(
                id: 2,
                title: "Running Shoes",
                price: 89.99,
                description: "Lightweight running shoes for all terrains.",
                category: ".sports",
                imageString: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg"
            ),
            Product(
                id: 3,
                title: "Wooden Coffee Table",
                price: 129.99,
                description: "Elegant wooden coffee table with a natural finish.",
                category: ".home",
                imageString: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg"
            ),
            Product(
                id: 4,
                title: "Classic Novel",
                price: 14.99,
                description: "A timeless classic novel with an engaging story.",
                category: ".books",
                imageString: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg"
            ),
            Product(
                id: 5,
                title: "Leather Jacket",
                price: 199.99,
                description: "Stylish leather jacket for a modern look.",
                category: ".fashion",
                imageString: "leather_jacket_image"
            )
        ]
    }
}
