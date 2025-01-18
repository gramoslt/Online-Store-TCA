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
                imageString: "wireless_earbuds_image"
            ),
            Product(
                id: 2,
                title: "Running Shoes",
                price: 89.99,
                description: "Lightweight running shoes for all terrains.",
                category: ".sports",
                imageString: "running_shoes_image"
            ),
            Product(
                id: 3,
                title: "Wooden Coffee Table",
                price: 129.99,
                description: "Elegant wooden coffee table with a natural finish.",
                category: ".home",
                imageString: "coffee_table_image"
            ),
            Product(
                id: 4,
                title: "Classic Novel",
                price: 14.99,
                description: "A timeless classic novel with an engaging story.",
                category: ".books",
                imageString: "classic_novel_image"
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
