//
//  ProductListDomain.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 23/01/25.
//

import Foundation
import ComposableArchitecture

struct ProductListDomain: Equatable {
    struct State: Equatable {
        var productList: IdentifiedArrayOf<ProductDomain.State> = []
    }

    enum Action: Equatable {
        case fetchProducts
        case fetchProductResponse(TaskResult<[Product]>)
        case product(id: ProductDomain.State.ID, action: ProductDomain.Action)
    }

    struct Environment {
        var fetchProducts: () async throws -> [Product]
    }

    static let reducer = AnyReducer<
        State, Action, Environment
    >.combine(
        ProductDomain.reducer.forEach(
            state: \.productList,
            action: /ProductListDomain.Action.product(id:action:),
            environment: { _ in ProductDomain.Environment()}
        ),
        .init { state, action, environment in
            switch action {
                case .fetchProducts:
                    return Effect.task {
                        await .fetchProductResponse(
                            TaskResult {
                                try await environment.fetchProducts()
                            }
                        )
                    }
                case .fetchProductResponse(.success(let products)):
                    state.productList = IdentifiedArray(
                        uniqueElements: products
                            .map {
                                ProductDomain.State.init(id: UUID(), product: $0)
                            }
                    )
                    return .none
                case .fetchProductResponse(.failure(let error)):
                    print(error)
                    print("Unable to fetch products")
                    return .none
                case .product:
                    return .none
            }
        }
    )
    
}
