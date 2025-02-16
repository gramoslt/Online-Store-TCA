//
//  ProductCell.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import SwiftUI
import ComposableArchitecture

struct ProductCell: View {
    let store: Store<ProductDomain.State, ProductDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                AsyncImage(
                    url: URL(
                        string: viewStore.product.imageString)
                ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)

                } placeholder: {
                    ProgressView()
                        .frame(height: 300)
                }

                VStack(alignment: .leading) {
                    Text(viewStore.product.title)
                    HStack {
                        Text("$ \(viewStore.product.price.description)")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        AddToCartButton(store: self.store.scope(state: \.addToCartState, action: ProductDomain.Action.addToCart))
                    }
                }
                .font(.title3)
            }
            .padding(20)
        }
    }
}

#Preview {
    ProductCell(store: Store(
        initialState: ProductDomain.State(
            id: UUID(),
            product: Product.sample[0]),
        reducer: ProductDomain.reducer,
        environment: ProductDomain.Environment()
    ))
}
