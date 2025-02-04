//
//  CartListDomain.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 25/01/25.
//

import Foundation
import ComposableArchitecture

struct CartListDomain: Equatable {
    struct State: Equatable {
        var cartItems: IdentifiedArrayOf<CartItemDomain.State> = []
    }

    enum Action: Equatable {
        case didPressCloseButton
        case cartItem(id: CartItemDomain.State.ID, action: CartItemDomain.Action)
    }

    struct Environment {}

    static let reducer = AnyReducer<
        State, Action, Environment
    >.combine(
        CartItemDomain.reducer.forEach(
            state: \.cartItems,
            action: /Action.cartItem(id:action:),
            environment: {_ in CartItemDomain.Environment()}
        ),
        .init { state, action, environment in
            switch action {
                case .didPressCloseButton:
                    return .none
                case .cartItem(let id, let action):
                    switch action {
                        case .deleteCartItem:
                            state.cartItems.remove(id: id)
                    }
                    return .none
            }
        }
    )
}
