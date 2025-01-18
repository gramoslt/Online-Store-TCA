//
//  ContentView.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    var body: some View {
        PlusMinusButton(store: Store(
            initialState: AddToCartDomain.State(),
            reducer: AddToCartDomain.reducer,
            environment: AddToCartDomain.Environment()
        ))
    }
}

#Preview {
    ContentView()
}
