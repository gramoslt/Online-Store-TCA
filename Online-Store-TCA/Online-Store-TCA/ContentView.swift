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
        ProductListView(store:
                            Store(
                                initialState: ProductListDomain.State(), reducer: ProductListDomain.reducer,
                                environment: ProductListDomain.Environment( fetchProducts: { Product.sample })
                            )
        )
    }
}

#Preview {
    ContentView()
}
