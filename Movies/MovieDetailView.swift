//
//  MovieDetailView.swift
//  Movies
//
//  Created by Aaron Garman on 7/29/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State var favMoviesManager = FavMoviesManager() // why state here? see lab?
    @State var isFavorite = false
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                let urlString = URL(string:"https://image.tmdb.org/t/p/w500" + movie.backdropPath)
                AsyncImage(url: urlString) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill) // fit v fill
                        .frame(width: 400, height: 200)
                    //.padding(.leading, 10)
                    //.ignoresSafeArea() maybe try cover top?
                    //.cornerRadius(10.0)
                    //.defaultScrollAnchor(.top)
                        .overlay(alignment: .bottomTrailing) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.white)
                                Button {
                                    isFavorite.toggle()
                                    if isFavorite {
                                        favMoviesManager.saveFavMovie(movie: movie)
                                    }
                                    else {
                                        favMoviesManager.deleteFavMovie(movie: movie)
                                    }
                                } label: {
                                    if isFavorite { // do var string then image, state?
                                        Image(systemName: "heart.fill")
                                            .imageScale(.large)
                                            .tint(.red)
                                    }
                                    else {
                                        Image(systemName: "heart")
                                            .imageScale(.large)
                                            .tint(.red)
                                    }
                                }
                            }
                            .padding(.trailing, 16)
                            .padding(.bottom, 4)
                        }
                } placeholder: {
                    Color(.systemGray4)
                }
                HStack(alignment: .top) {
                    let urlString = URL(string:"https://image.tmdb.org/t/p/w500" + movie.posterPath)
                    AsyncImage(url: urlString) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill) // fit v fill
                            .frame(width: 150, height: 225)
                        //.padding(.leading, 4)
                            .cornerRadius(25.0)
                            .offset(y: -50)
                            .padding(.bottom, -50)
                            .overlay { // was parentheses before
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color.white, lineWidth: 3)
                                    .offset(y: -50)
                                    .padding(.bottom, -50)
                            }
                            .shadow(radius: 10)
                        // maybe move image as overlay somehow?
                        
                        
                    } placeholder: {
                        Color(.systemGray4)
                    }
                    //Spacer()
                    //.frame(width:20) // less here bring move in?
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.title2)
                            .bold()
                            .padding(.top, 12)
                            .frame(height: 100) // maybe no width here? width: 125,
                        Text("Released: \(movie.releaseDate)") // make into "mar 1, 2023" style. released v release v release date v none
                        //.padding(4) // these texts bigger?
                            .padding(.bottom, 4)
                        //.font(.title3)
                            .font(.system(size: 18)) // maybe to 20 once resize date?
                        HStack {
                            Text(String(format: "%.1f", movie.voteAverage) + "/10")
                                .foregroundStyle(.black) // need?
                            //.padding(4)
                            //.font(.title3)
                                .font(.system(size: 18))
                            Image(systemName: "star.fill")
                                .imageScale(.medium)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.trailing, 16) // need spacer or diff?
                    .padding(.leading, 12) // turn padding into usable space for title?
                    //.frame(width: 200)
                }
                //.padding(.leading, 8)
                HStack {
                    //Spacer() // just do padding for these 2 spacers?
                        //.frame(width: 12)
                    Text(movie.overview) // take out of h stack
                    //Spacer()
                        //.frame(width: 12)
                }
                .padding(.top, 12)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                //.offset(y: -35) // better way to do this? why is space there?
            } // outer v stack
            //.offset(y: -45) // better way?
            .navigationTitle("Movie Details")
            .navigationBarTitleDisplayMode(.inline)
            //.defaultScrollAnchor(.top)
            .padding(.top, 18)
        }// scroll
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

// spacer v padding for some?

// clean up all here, do button as overlay

// maybe put in scroll view? or too much space at top?
// diff font for stars n released? slight smaller or title slight bigger test. wolverine pic too close, maybe padding or spacer? or just diff font? see all
// diff date format?

// maybe anchor top image?


// give movie poster a bit more space, maybe padding on either stack or image itself? only some tho like garfield, or text maybe bit smaller width?

// release n stars font tad bigger
