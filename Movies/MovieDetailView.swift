//
//  MovieDetailView.swift
//  Movies
//
//  Created by Aaron Garman on 7/29/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    
    var body: some View {
        Text(movie.title)
    }
}

#Preview {
    MovieDetailView(movie: Movie(id: 1022789,
                           title: "Inside Out 2",
                           releaseDate: "2024-06-11",
                           overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
                           voteAverage: 7.634,
                           posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                           backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg"))
}

// do background as gray to keep theme w/ tab bar?

