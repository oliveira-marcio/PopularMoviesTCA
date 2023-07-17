//
//  MoviesClient.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import Foundation
import ComposableArchitecture

struct MoviesClient {
    var fetchMovies: () async throws -> [Movie]

    static var apiKey: String {
        guard let dict = Bundle.main.infoDictionary, let apiKey = dict["movies_api_key"] as? String else {
            fatalError("Configuration Plist file not found.")
        }
        return apiKey
    }
}

extension MoviesClient: DependencyKey {
    static let liveValue: MoviesClient = Self(
        fetchMovies: {
            let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=1")!)
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            let movies = try decoder.decode(MoviesEntity.self, from: data)
            return movies.results.map { Movie(from: $0) }
        }
    )
}

extension Movie {
    init(from entity: MovieEntity) {
        self.init(title: entity.title,
                  overview: entity.overview,
                  posterPath: "https://image.tmdb.org/t/p/w500\(entity.posterPath)",
                  releaseDate: entity.releaseDate)
    }
}

extension DependencyValues {
  var moviesClient: MoviesClient {
    get { self[MoviesClient.self] }
    set { self[MoviesClient.self] = newValue }
  }
}
