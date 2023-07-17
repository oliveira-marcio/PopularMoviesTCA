//
//  MoviesListView.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 17/07/2023.
//

import SwiftUI

struct MoviesListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
