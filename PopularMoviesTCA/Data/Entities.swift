//
//  Entities.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import Foundation

struct MoviesEntity: Decodable {
    let results: [MovieEntity]
}

struct MovieEntity: Decodable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var releaseDate: String
}
