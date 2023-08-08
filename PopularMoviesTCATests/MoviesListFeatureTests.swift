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
}
