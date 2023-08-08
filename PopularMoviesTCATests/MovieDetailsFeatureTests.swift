//
//  MovieDetailsFeatureTests.swift
//  PopularMoviesTCATests
//
//  Created by Márcio Oliveira on 08/08/2023.
//

import XCTest
import ComposableArchitecture
@testable import PopularMoviesTCA

@MainActor
final class MovieDetailsFeatureTests: XCTestCase {

    func testFavoriteButtonTapped() async {
        let store = TestStore(
            initialState: MovieDetailsFeature.State(
                movie: Movie(title: "",
                             overview: "",
                             posterPath: "",
                             releaseDate: "",
                             isFavorite: false)
            )
        ) {
            MovieDetailsFeature()
        } withDependencies: {
            $0.moviesClient.fetchMovies = { [] }
        }

        await store.send(.favoriteButtonTapped) {
            $0.movie.isFavorite = true
        }
        await store.send(.favoriteButtonTapped) {
            $0.movie.isFavorite = false
        }
    }
}
