//
//  MovieListItem.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 19/07/2023.
//

import SwiftUI

struct MovieListItem: View {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        HStack {
            PosterImage(urlString: movie.posterPath,
                        width: 50,
                        height: 75)
            Text(movie.title)
                .bold()
                .foregroundColor(movie.isFavorite ? .blue : .black)
        }
    }
}

struct MovieListItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItem(movie: Movie(id: 1,
                                   title: "Movie 1",
                                   overview: "",
                                   posterPath: "",
                                   releaseDate: ""))
    }
}
