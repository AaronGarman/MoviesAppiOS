//
//  MovieDetailView.swift
//  Movies
//
//  Created by Aaron Garman on 7/29/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    //@State var favMoviesManager = FavMoviesManager()
    @Environment(FavMoviesManager.self) var favMoviesManager
    @State var isFavorite = false
    
    @Binding var movies: [Movie]
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                let urlString = URL(string:"https://image.tmdb.org/t/p/w500" + movie.backdropPath)
                AsyncImage(url: urlString) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(alignment: .bottomTrailing) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.white)
                                Button {
                                    isFavorite.toggle()
                                    
                                    // any way add/delete/check both array n db together?
                                    // should state and db array be diff?
                                    // if spam button 3+ times will sometimes keep in even if unfaved, fig why? keeps in array but not db - state issue not db? what if just dropped requests from click overload msg in console? try debouncing? or inconsisten array data since changes so many times quickly?
                                    
                                    if isFavorite {
                                        
                                        if movies == favMoviesManager.favMovies {
                                            // put check because spam button sometimes leaves in? diff cause of this?
                                            /*if !movies.contains(where: { $0.id == movie.id }) {
                                                movies.append(movie)
                                            } */
                                            movies.append(movie) // if spam button sometimes will keep fav in even if not checked?
                                        }
                                        // try do db stuff after so state updates first
                                        favMoviesManager.saveFavMovie(movie: movie)
                                    }
                                    else {
                                        
                                        // will this not work on reg screen tho? only removes if on favs screen w/ favs list
                                        if movies == favMoviesManager.favMovies { // any reason not to work? reference not contents so ok? diff way to check if in favs?
                                            movies.removeAll { $0.id == movie.id }
                                            //favMoviesManager.getFavMovies()
                                            //movies = favMoviesManager.favMovies
                                        }
                                        // try do db stuff after so state updates first
                                        favMoviesManager.deleteFavMovie(movie: movie)
                                    }
                                   // could try db funcs as async like api?
                                } label: {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .imageScale(.large)
                                        .tint(.red)
                                }
                                .onAppear {
                                    /*if movies == favMoviesManager.favMovies {
                                        movies = favMoviesManager.favMovies
                                    }*/
                                    isFavorite = favMoviesManager.favMovies.contains(where: { $0.id == movie.id })
                                }
                                /*.onAppear {
                                    if favMoviesManager.favMovies.contains(movie) {
                                        isFavorite = true
                                    }
                                } */
                            }
                            .padding([.trailing, .bottom], 12)
                        }
                } placeholder: {
                    Color(.systemGray4)
                        .frame(height: 250) // for less screen movement on rendering
                }
                HStack(alignment: .top) {
                    let urlString = URL(string:"https://image.tmdb.org/t/p/w500" + movie.posterPath)
                    AsyncImage(url: urlString) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 225)
                            .cornerRadius(25.0)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(Color.white, lineWidth: 3)
                            }
                            .shadow(radius: 10)
                    } placeholder: {
                        Color(.systemGray4)
                    }
                    .offset(y: -60)
                    .padding(.bottom, -60)
                    .padding(.leading, 12)
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.title2)
                            .bold()
                            .padding(.top, 4)
                        Text("Release: \(movie.formattedDate)")
                            .padding(.top, 4)
                            .font(.system(size: 18))
                        HStack {
                            Text(String(format: "%.1f", movie.voteAverage) + "/10")
                                .font(.system(size: 18))
                            Image(systemName: "star.fill")
                                .imageScale(.medium)
                                .foregroundColor(.yellow)
                        }
                        .padding(.top, 4)
                    }
                    .padding(.trailing, 12)
                    .padding(.leading, 8)
                    Spacer()
                }
                //Text("\(favMoviesManager.favMovies.count)") // movie.overview
                Text("\(movie.overview)")
                    .padding([.top, .leading, .trailing], 16)
            }
            .padding(.top, 4)
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MovieDetailView(movies: .constant([]), movie: Movie(id: 1022789,
                                 title: "Inside Out 2",
                                 releaseDate: "2024-06-11",
                                 overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
                                 voteAverage: 7.634,
                                 posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                                 backdropPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg"))
    .environment(FavMoviesManager())
}

// release n stars font tad bigger? title more top padding? eh
// backdrop image slight blurry?

// do background as gray to keep theme w/ tab bar?
