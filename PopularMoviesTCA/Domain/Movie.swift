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
