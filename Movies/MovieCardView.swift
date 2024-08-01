//
//  MovieCardView.swift
//  Movies
//
//  Created by Aaron Garman on 7/26/24.
//

import SwiftUI

struct MovieCard: View {
    
    let movie: Movie
    
    var body: some View {
        // Vstack of entire view - for card rectangle + title below
        VStack {
            // Rectangle to hold contents of card
            Rectangle()
                .frame(width: 150, height: 250)
                //.cornerRadius(10.0)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 4, x: -2, y: 2)
                .overlay(alignment: .bottom) {
                    
                    // setup image URL for image view
                    
                    let urlString = URL(string:"https://image.tmdb.org/t/p/w500" + movie.posterPath)
                    
                    // Vstack for card image + stars
                    VStack {
                        AsyncImage(url: urlString) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                //.cornerRadius(10.0)
                        } placeholder: {
                            Color(.systemGray4)
                        }
                        // HStack for rating text + star image
                        HStack {
                            Spacer()
                                .frame(width: 15)
                            Text(String(format: "%.1f", movie.voteAverage) + "/10")
                                .foregroundStyle(.black)
                            Image(systemName: "star.fill")
                                .imageScale(.medium)
                                .foregroundColor(.yellow)
                        }
                        .padding(.bottom, 8)
                        .padding(.top, 2)
                    }
                }
            Text(movie.title)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                //.frame(width: 150, height: 50)
                .frame(width: 150)
                .padding(.top, 2)
        }
       .frame(width: 150, height: 250)
        //.padding(.top, 16)
    }
}

#Preview {
    MovieCard(movie: Movie(id: 1022789,
                           title: "Inside Out 2",
                           releaseDate: "2024-06-11",
                           overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
                           voteAverage: 7.634,
                           posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                           backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg"))
}

// rounded border rectangle n image? 10 pt? just do rounded rectangle?
// room for title text - maybe do as textview? or height 50 n more padding? align at top?

