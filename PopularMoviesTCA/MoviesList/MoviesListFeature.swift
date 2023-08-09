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
        var path = StackState<MovieDetailsFeature.State>()
    }

    enum Action: Equatable {
        case appLaunched
        case moviesResponse(TaskResult<[Movie]>)
        case path(StackAction<MovieDetailsFeature.State, MovieDetailsFeature.Action>)
    }

    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
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

            case let .path(.element(id: id, action: .delegate(.toggleFavorite))):
                guard let movie = state.path[id: id]?.movie,
                      let index = state.movies.firstIndex(where: { $0.id == movie.id })
                else { return .none}
                state.movies.update(movie, at: index)
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            MovieDetailsFeature()
        }
    }
}
