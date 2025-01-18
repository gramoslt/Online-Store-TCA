//
//  ProductDomain.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import Foundation
import ComposableArchitecture

struct ProductDomain {

    struct State: Equatable {
        let product: Product
        var addToCartState = AddToCartDomain.State()
    }

    enum Action: Equatable {
        case addToCart(AddToCartDomain.Action)
    }

    struct Environment {}

    static let reducer = AnyReducer<
        State, Action, Environment
    >.combine(
        .init { state, action, environment in
            switch action {
                case .addToCart(.didTapPlusButton):
                    return .none
                case .addToCart(.didTapMinusButton):
                    state.addToCartState.count = max(0, state.addToCartState.count)
                    return .none
            }
        }
    )
}
