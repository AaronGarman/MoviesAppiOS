//
//  MoviesGridView.swift
//  Movies
//
//  Created by Aaron Garman on 7/24/24.
//

import SwiftUI

struct MoviesGridView: View {
    
    @Environment(AuthManager.self) var authManager // test
    @Environment(FavMoviesManager.self) var favMoviesManager
    @Environment(MovieApiManager.self) var movieApiManager
    
    @State var isNowPlaying: Bool // is passing in state again weird? see how ui functions. old style better?
    @State private var movies: [Movie] = [] // store movies retrieved from API
    
    //@EnvironmentObject var movies: [Movie] = []
    
    let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(movies) { movie in
                            NavigationLink(value: movie) {
                                MovieCard(movie: movie)
                            }
                            .padding(.top, 60)
                            .padding(.bottom, 60)
                        }
                    }
                    .padding(.top, 12)
                }
                .padding(.leading, 12) // better way these 2? for outside edges
                .padding(.trailing, 12)
                .navigationTitle("Movies")
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                        .environment(favMoviesManager)
                }
                .toolbar {
                    ToolbarItem {
                        Button("Sign out") {
                            authManager.signOut()
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            if isNowPlaying {
                Task {
                    await movieApiManager.fetchMovies()
                    movies = movieApiManager.movies
                }
            }
            else {
                movies = favMoviesManager.favMovies // this needs to get updated after delete, closure or observed?
            }
        })
    }
    

}

#Preview {
    MoviesGridView(isNowPlaying: true)
        .environment(AuthManager()) // test - put other 2 auth vars here?
        .environment(FavMoviesManager())
        .environment(MovieApiManager())
}

// maybe less space in between cards?


// maybe use this as template for reg and favorites

// why when touch in middle skews to one side? here or card self?

// what if movie manager for api grab, but for this view just pass in which array for api ones or fav ones
