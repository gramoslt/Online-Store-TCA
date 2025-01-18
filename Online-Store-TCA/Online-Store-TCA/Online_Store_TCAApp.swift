//
//  Online_Store_TCAApp.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct Online_Store_TCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialState: CounterDomain.State(),
                reducer: CounterDomain.reducer,
                environment: CounterDomain.Environment()
            ))
        }
    }
}
