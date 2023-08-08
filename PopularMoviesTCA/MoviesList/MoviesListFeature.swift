//
//  MoviesListFeature.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import Foundation
import ComposableArchitecture

struct MoviesListFeature: ReducerProtocol {
    @Dependency(\.moviesClient) var moviesClient

    struct State: Equatable {
        var movies: IdentifiedArrayOf<Movie> = []
        var apiError: String?
    }

    enum Action: Equatable {
        case appLaunched
        case moviesResponse(TaskResult<[Movie]>)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .appLaunched:
            return .run { send in
                await send(.moviesResponse(
                    TaskResult {
                        try await moviesClient.fetchMovies()
                    }
                ))
            }

        case let .moviesResponse(.success(movies)):
            state.movies.append(contentsOf: movies)
            state.apiError = nil
            return .none

        case let .moviesResponse(.failure(error)):
            state.movies = []
            state.apiError = error.localizedDescription
            return .none
        }
    }
}
