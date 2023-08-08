//
//  MovieDetailsView.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 08/08/2023.
//

import SwiftUI
import ComposableArchitecture

struct MovieDetailsView: View {
    let store: StoreOf<MovieDetailsFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                ScrollView {
                    VStack {
                        PosterImage(urlString: viewStore.movie.posterPath,
                                    width: 200,
                                    height: 300)
                        .padding(3)
                        Text(viewStore.movie.title)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(3)
                        Text(viewStore.movie.overview)
                            .padding(3)
                        Text("Released: \(viewStore.movie.releaseDate)")
                        Spacer()
                    }
                }
                FloatingActionButton(isFavorite: viewStore.movie.isFavorite) {
                    store.send(.favoriteButtonTapped)
                }
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(
            store: Store(
                initialState: MovieDetailsFeature.State(
                    movie: Movie(title: "Matrix",
                                 overview: "Nice movie about people killing each other in a fake world",
                                 posterPath: "foo.com",
                                 releaseDate: "1/1/1999")
                )
            ) {
                MovieDetailsFeature()
            }
        )
    }
}
