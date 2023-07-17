//
//  PopularMoviesTCAApp.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct PopularMoviesTCAApp: App {
    static let store = Store(initialState: MoviesListFeature.State()) {
        MoviesListFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            MoviesListView(store: PopularMoviesTCAApp.store)
        }
    }
}
