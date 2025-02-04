//
//  CartCell.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 25/01/25.
//

import SwiftUI
import ComposableArchitecture

struct CartCell: View {
    let store: Store<CartItemDomain.State, CartItemDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack {
                    AsyncImage(
                        url: URL(
                            string: viewStore.cartItem.product.imageString)
                    ) {
                        $0
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)

                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    VStack(alignment: .leading) {
                        Text(viewStore.state.cartItem.product.title)
                            .lineLimit(3)
                            .minimumScaleFactor(0.5)
                        HStack {
                            Text("$ \(viewStore.state.cartItem.product.price.description)")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
                
            }
            ZStack {
                Group {
                    Text("Quantity: ")
                    +
                    Text("\(viewStore.state.cartItem.quantity)")
                        .fontWeight(.bold)
                }
                .font(.title)

                HStack {
                    Spacer()
                    Button {
                        viewStore.send(
                            .deleteCartItem(
                                product: viewStore.cartItem.product
                            )
                        )
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(.red)
                            .padding()
                    }
                }
            }
        }
        .font(.title2)
        .padding([.bottom, .top], 10)
    }
}

#Preview {
    CartCell(
        store: Store(
            initialState: CartItemDomain.State.init(
                id: UUID(),
                cartItem: CartItem.sample[0]
            ),
            reducer: CartItemDomain.reducer,
            environment: CartItemDomain.Environment()
        )
    )
}
