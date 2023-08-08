//
//  Movie.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import Foundation

struct Movie: Hashable {
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    var isFavorite: Bool

    init(title: String,
         overview: String,
         posterPath: String,
         releaseDate: String,
         isFavorite: Bool = false) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.isFavorite = isFavorite
    }
}
