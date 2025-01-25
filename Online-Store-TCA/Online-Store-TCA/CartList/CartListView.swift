//
//  CartListView.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 25/01/25.
//

import SwiftUI
import ComposableArchitecture

struct CartListView: View {
    let store: Store<CartListDomain.State, CartListDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationStack {
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.cartItems,
                            action: CartListDomain.Action.cartItem(id:action:)
                        )
                    ) {
                        CartCell(store: $0)
                    }
                }
                .navigationTitle("Cart")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            viewStore.send(.didPressCloseButton)
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CartListView(
        store: Store(
            initialState: CartListDomain.State(
                cartItems: IdentifiedArray(
                    uniqueElements: CartItem.sample
                        .map {
                            CartItemDomain.State(
                                id: UUID(),
                                cartItem: $0
                            )
                        }
                )
            ),
            reducer: CartListDomain.reducer,
            environment: CartListDomain.Environment()
        )
    )
}
