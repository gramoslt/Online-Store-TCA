//
//  CartItemDomain.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 25/01/25.
//

import Foundation
import ComposableArchitecture

struct CartItemDomain: Equatable {
    struct State: Equatable, Identifiable{
        let id: UUID
        let cartItem: CartItem
    }

    enum Action: Equatable {
        case deleteCartItem(product: Product)
    }

    struct Environment {

    }

    static let reducer = AnyReducer<
        State, Action, Environment
    >.init { state, action, environment in
        switch action {
            case .deleteCartItem:
                return .none
        }
    }
}
