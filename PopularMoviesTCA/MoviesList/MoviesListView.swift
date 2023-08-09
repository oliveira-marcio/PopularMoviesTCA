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
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    if let apiError = viewStore.apiError {
                        ErrorView(errorMessage: apiError)
                    } else {
                        List {
                            ForEach(viewStore.movies) { movie in
                                NavigationLink(state: MovieDetailsFeature.State(movie: movie)) {
                                    MovieListItem(movie: movie)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
                .task {
                    viewStore.send(.appLaunched)
                }
            }
        } destination: { store in
            MovieDetailsView(store: store)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    enum AnError: LocalizedError {
        case oops
        var errorDescription: String? { "Something went wrong" }
    }

    static var previews: some View {
        Group {
            MoviesListView(store: getWorkingStore())
                .previewDisplayName("Movies List")
            MoviesListView(store: getFailingStore())
                .previewDisplayName("API Error")
        }
    }

    private static func getWorkingStore() -> Store<MoviesListFeature.State, MoviesListFeature.Action> {
        getStore {
            $0.moviesClient.fetchMovies = {
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
    }

    private static func getFailingStore() -> Store<MoviesListFeature.State, MoviesListFeature.Action> {
        getStore {
            $0.moviesClient.fetchMovies = {
                throw AnError.oops
            }
        }
    }

    private static func getStore(withDependencies: ((inout DependencyValues) -> Void)? = nil) -> Store<MoviesListFeature.State, MoviesListFeature.Action> {
        Store(initialState: MoviesListFeature.State(),
              reducer: { MoviesListFeature() },
              withDependencies: withDependencies)
    }
}
