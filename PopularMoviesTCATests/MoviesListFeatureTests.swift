//
//  MoviesListFeatureTests.swift
//  PopularMoviesTCATests
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import XCTest
import ComposableArchitecture
@testable import PopularMoviesTCA

@MainActor
final class MoviesListFeatureTests: XCTestCase {

    var store: TestStore<MoviesListFeature.State, MoviesListFeature.Action, MoviesListFeature.State, MoviesListFeature.Action, ()>!

    override func setUp() {
        store = TestStore(initialState: MoviesListFeature.State()) {
            MoviesListFeature()
        } withDependencies: {
            $0.moviesClient.fetchMovies = { [] }
        }
        super.setUp()
    }

    override func tearDown() {
        store = nil
        super.tearDown()
    }

    func testAppLaunch_withSuccessfulApiResponse() async {
        let testMovie = Movie(id: 1,
                              title: "Title",
                              overview: "Overview",
                              posterPath: "Poster",
                              releaseDate: "Date")
        store.dependencies.moviesClient.fetchMovies = { [testMovie] }

        await store.send(.appLaunched)

        await store.receive(.moviesResponse(.success([testMovie]))) {
            $0.movies = [testMovie]
        }
    }

    func testAppLaunch_withApiFailure() async {
        enum ApiError: LocalizedError {
            case failure
            var errorDescription: String? { "API Failure" }
        }
        store.dependencies.moviesClient.fetchMovies = { throw ApiError.failure }

        await store.send(.appLaunched)

        await store.receive(.moviesResponse(.failure(ApiError.failure))) {
            $0.apiError = "API Failure"
        }
    }

    func testAddMovieToFavorites() async {
        let movie1 = Movie(id: 1, title: "", overview: "", posterPath: "", releaseDate: "", isFavorite: false)
        let movie2 = Movie(id: 2, title: "", overview: "", posterPath: "", releaseDate: "", isFavorite: false)
        let favoriteMovie1 = Movie(id: 1, title: "", overview: "", posterPath: "", releaseDate: "", isFavorite: true)

        store.dependencies.moviesClient.fetchMovies = { [movie1, movie2] }
        store.exhaustivity = .off

        await store.send(.appLaunched)
        await store.send(.path(.push(id: 0, state: MovieDetailsFeature.State(movie: movie1))))
        await store.send(.path(.element(id: 0, action: .favoriteButtonTapped)))
        await store.skipReceivedActions()

        store.assert {
            $0.movies = [favoriteMovie1, movie2]
        }
    }

    func testRemoveMovieFromFavorites() async {
        let favoriteMovie1 = Movie(id: 1, title: "", overview: "", posterPath: "", releaseDate: "", isFavorite: true)
        let favoriteMovie2 = Movie(id: 2, title: "", overview: "", posterPath: "", releaseDate: "", isFavorite: true)
        let movie1 = Movie(id: 1, title: "", overview: "", posterPath: "", releaseDate: "", isFavorite: false)

        store.dependencies.moviesClient.fetchMovies = { [favoriteMovie1, favoriteMovie2] }
        store.exhaustivity = .off

        await store.send(.appLaunched)
        await store.send(.path(.push(id: 0, state: MovieDetailsFeature.State(movie: favoriteMovie1))))
        await store.send(.path(.element(id: 0, action: .favoriteButtonTapped)))
        await store.skipReceivedActions()

        store.assert {
            $0.movies = [movie1, favoriteMovie2]
        }
    }
}
