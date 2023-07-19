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
                        ForEach(viewStore.movies, id:\.self) { movie in
                            Text(movie.title)
                                .bold()
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

struct ErrorView: View {
    let errorMessage: String

    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding(0.5)
            Text("Error: \(errorMessage)")
            Spacer()
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
// For debugging
//                throw AError.oops
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
