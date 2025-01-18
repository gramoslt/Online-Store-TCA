//
//  PlusMinusButton.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import SwiftUI
import ComposableArchitecture

struct PlusMinusButton: View {
    let store: Store<AddToCartDomain.State, AddToCartDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button {
                    viewStore.send(.didTapMinusButton)
                } label: {
                    Text("-")
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)

                Text(viewStore.state.count.description)
                    .padding(5)

                Button {
                    viewStore.send(.didTapPlusButton)
                } label: {
                    Text("+")
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
    PlusMinusButton(
        store: Store(
            initialState: AddToCartDomain.State(),
            reducer: AddToCartDomain.reducer,
            environment: AddToCartDomain.Environment()
        )
    )
}
