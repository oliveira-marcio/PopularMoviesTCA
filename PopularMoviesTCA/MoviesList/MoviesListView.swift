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
                Text("Movies")
                    .font(.largeTitle)
                if let apiError = viewStore.apiError {
                    ErrorView(errorMessage: apiError)
                } else {
                    List {
                        ForEach(viewStore.movies) { movie in
                            MovieListItem(movie: movie)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .task {
                viewStore.send(.appLaunched)
            }
        }
    }
}

// For debugging
enum AnError: Error {
    case oops
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: MoviesListFeature.State()) {
            MoviesListFeature()
        } withDependencies: {
            $0.moviesClient.fetchMovies = {
// For debugging
//                throw AnError.oops
                [
                    Movie(id: 1,
                          title: "Movie 1",
                          overview: "",
                          posterPath: "",
                          releaseDate: ""),
                    Movie(id: 2,
                          title: "Movie 2",
                          overview: "",
                          posterPath: "",
                          releaseDate: ""),
                    Movie(id: 3,
                          title: "Movie 3",
                          overview: "",
                          posterPath: "",
                          releaseDate: "")

                ]
            }
        }
        return MoviesListView(store: store)
    }
}
