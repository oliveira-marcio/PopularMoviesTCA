//
//  MoviesClient.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import Foundation

struct MoviesEntity: Decodable {
    let results: [MovieEntity]
}

struct MovieEntity: Decodable {
    var title: String
    var overview: String
    var posterPath: String
    var releaseDate: String
}

struct Movie: Hashable {
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String

    init(title: String,
         overview: String,
         posterPath: String,
         releaseDate: String) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
}

extension Movie {
    init(from entity: MovieEntity) {
        self.init(title: entity.title,
                  overview: entity.overview,
                  posterPath: "https://image.tmdb.org/t/p/w500\(entity.posterPath)",
                  releaseDate: entity.releaseDate)
    }
}

class MoviesClient {
    static var shared: MoviesClient {
        MoviesClient()
    }

    private init() {}

    func fetchMovies() async throws -> [Movie] {
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(getApiKey())&page=1")!)
        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let movies = try decoder.decode(MoviesEntity.self, from: data)
        return movies.results.map { Movie(from: $0) }
    }

    private func getApiKey() -> String {
        guard let dict = Bundle.main.infoDictionary, let apiKey = dict["movies_api_key"] as? String else {
            fatalError("Configuration Plist file not found.")
        }

        return apiKey
    }
}
