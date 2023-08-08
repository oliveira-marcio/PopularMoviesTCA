//
//  FloatingActionButton.swift
//  PopularMoviesTCA
//
//  Created by Márcio Oliveira on 08/08/2023.
//

import SwiftUI

struct FloatingActionButton: View {

    let isFavorite: Bool
    let action: () -> Void

    init(isFavorite: Bool, action: @escaping () -> Void = {}) {
        self.isFavorite = isFavorite
        self.action = action
    }

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "\(isFavorite ? "checkmark" : "plus").circle.fill")
                        .font(.system(size: 64))
                        .foregroundColor(isFavorite ? .green : .purple)
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                        .padding()
                }
            }
        }
    }
}

struct FloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FloatingActionButton(isFavorite: false)
                .previewDisplayName("FAB No favorite")
            FloatingActionButton(isFavorite: true)
                .previewDisplayName("FAB Favorite")
        }
    }
}
