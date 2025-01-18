//
//  AddToCartButton.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import SwiftUI
import ComposableArchitecture

struct AddToCartButton: View {
    let store: Store<AddToCartDomain.State, AddToCartDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            if viewStore.count > 0 {
                PlusMinusButton(store: self.store)
            } else {
                Button{
                    viewStore.send(.didTapPlusButton)
                } label: {
                    Text("Add To Cart")
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    AddToCartButton(
        store: Store(
        initialState: AddToCartDomain.State(),
        reducer: AddToCartDomain.reducer,
        environment: AddToCartDomain.Environment()
    ))
}
