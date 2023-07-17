//
//  MoviesListView.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct MoviesListView: View {
    let store: StoreOf<MoviesListFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                if let apiError = viewStore.apiError {
                    Text("Error: \(apiError)")
                } else {
                    Text("Movies: \(viewStore.movies.count)")
                }
            }
            .padding()
            .task {
                viewStore.send(.appLaunched)
            }
        }
    }
}

enum AError: Error {
    case oops
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: MoviesListFeature.State()) {
            MoviesListFeature()
        } withDependencies: {
            $0.moviesClient.fetchMovies = {
                [
                    Movie(title: "Matrix",
                          overview: "",
                          posterPath: "",
                          releaseDate: "")
                ]
            }
        }
        return MoviesListView(store: store)
    }
}
