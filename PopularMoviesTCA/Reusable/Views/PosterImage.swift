//
//  PosterImage.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 19/07/2023.
//

import SwiftUI

struct PosterImage: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat

    init(urlString: String, width: CGFloat, height: CGFloat) {
        self.urlString = urlString
        self.width = width
        self.height = height
    }

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .background(Color.gray)
        }.frame(width: width, height: height)
    }
}

struct PosterImage_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(urlString: "",
                    width: 100,
                    height: 150)
    }
}
