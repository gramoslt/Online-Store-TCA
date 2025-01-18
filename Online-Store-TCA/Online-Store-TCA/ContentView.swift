//
//  ContentView.swift
//  Online-Store-TCA
//
//  Created by Gerardo Ramos on 18/01/25.
//

import SwiftUI
import ComposableArchitecture

struct CounterDomain {
    struct State: Equatable {
        var counter = 0
    }

    enum Action: Equatable {
        case increaseCounter
        case decreaseCounter
    }

    struct Environment {

    }

    static let reducer = AnyReducer<State, Action, Environment> { state, action, environment in
        switch action {
            case .increaseCounter:
                state.counter += 1
                return .none
            case .decreaseCounter:
                state.counter -= 1
                return .none
        }
    }
}

struct ContentView: View {
    let store: Store<CounterDomain.State, CounterDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button {
                    viewStore.send(.decreaseCounter)
                } label: {
                    Text("-")
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)

                Text(viewStore.state.counter.description)
                    .padding(5)

                Button {
                    viewStore.send(.increaseCounter)
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
    ContentView(
        store: Store(
            initialState: CounterDomain.State(),
            reducer: CounterDomain.reducer,
            environment: CounterDomain.Environment()
        )
    )
}
