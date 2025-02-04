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
        var cartState: CartListDomain.State?
        var shouldOpenCart = false
    }

    enum Action: Equatable {
        case fetchProducts
        case fetchProductResponse(TaskResult<[Product]>)
        case product(id: ProductDomain.State.ID, action: ProductDomain.Action)
        case setCart(isPresented: Bool)
        case cart(CartListDomain.Action)
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
        CartListDomain.reducer
            .optional()
            .pullback(
            state: \.cartState,
            action: /Action.cart,
            environment: { _ in CartListDomain.Environment()})
        ,
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
                case .cart(let action):
                    switch action {
                        case .didPressCloseButton:
                            state.shouldOpenCart = false
                        case .cartItem(_,let action):
                            switch action {
                                case .deleteCartItem(let product):
                                    guard let index = state.productList.firstIndex(
                                        where: { $0.product.id == product.id }
                                    ) else { return .none }
                                    let productStateId = state.productList[index].id
                                    state.productList[id: productStateId]?.count = 0
                            }
                    }
                    return .none
                case .setCart(let isPresented):
                    state.shouldOpenCart = isPresented
                    state.cartState = isPresented
                    ? CartListDomain.State(
                        cartItems: IdentifiedArray(
                            uniqueElements: state.productList.compactMap { state in
                                state.addToCartState.count > 0
                                ? CartItemDomain.State(
                                    id: UUID(),
                                    cartItem: CartItem(
                                        product: state.product,
                                        quantity: state.count
                                    )
                                )
                                : nil
                            }
                        )
                    )
                    : nil
                    return .none
            }
        }
    )
}
