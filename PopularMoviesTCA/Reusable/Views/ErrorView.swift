//
//  ErrorView.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 19/07/2023.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String

    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding(0.5)
            Text(errorMessage)
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "This is an error")
    }
}
