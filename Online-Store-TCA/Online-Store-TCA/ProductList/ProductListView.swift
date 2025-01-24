//
//  ProductListView.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 23/01/25.
//

import SwiftUI
import ComposableArchitecture

struct ProductListView: View {
    let store: Store<ProductListDomain.State, ProductListDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                ForEachStore (
                    self.store.scope(
                        state: \.productList,
                        action: ProductListDomain.Action
                            .product(id:action:)
                    )
                ) {
                    ProductCell(store: $0)
                }
            }.task {
                viewStore.send(.fetchProducts)
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(
            store: .init(
                initialState: .init(),
                reducer: ProductListDomain.reducer,
                environment: ProductListDomain.Environment(
                    fetchProducts: { Product.sample }
                )
            )
        )
    }
}
