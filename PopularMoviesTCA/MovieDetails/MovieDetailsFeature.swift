//
//  MovieDetailsFeature.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 08/08/2023.
//

import Foundation
import ComposableArchitecture

struct MovieDetailsFeature: ReducerProtocol {
    struct State: Equatable {
        var movie: Movie
    }
    
    enum Action: Equatable {
        case favoriteButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .favoriteButtonTapped:
            state.movie.isFavorite.toggle()
            return .none
        }
    }
}
