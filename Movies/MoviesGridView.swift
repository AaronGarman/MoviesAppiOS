//
//  MoviesGridView.swift
//  Movies
//
//  Created by Aaron Garman on 7/24/24.
//

import SwiftUI

struct MoviesGridView: View {
    
    @Environment(AuthManager.self) var authManager // test
    
    @State private var movies: [Movie] = [] // store movies retrieved from API
    
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
            Task {
                await fetchMovies()
            }
        })
    }
    
    // function to retrieve movie data from API
    
    private func fetchMovies() async {
        
        // url for TMDB movies database "now playing" endpoint
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b1446bbf3b4c705c6d35e7c67f59c413&language=en-US")!
        do {

            // data request
            
            // can loop through api w/ page numbers to get more movies - would use variable in api string for page number
            
            let (data, response) = try await URLSession.shared.data(from: url)
            let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
            
            // print response status code - for testing

            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)\n")
            }
            
            // get response data
            
            self.movies = moviesResponse.results

            // print data for each movie - for testing
            
            printMovies()
 
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // function to print out all data for each movie
    
    private func printMovies() {
        
        print("Total movies: \(movies.count)\n")
        
        for movie in movies {
            print("Id: \(movie.id)")
            print("Title: \(movie.title)")
            print("Release Date: \(movie.releaseDate)")
            print("Overview: \(movie.overview)")
            print("Vote Average: \(movie.voteAverage)")
            print("Poster Path: \(movie.posterPath)")
            print("Backdrop Path: \(movie.backdropPath)\n")
        }
    }
}

#Preview {
    MoviesGridView()
        .environment(AuthManager()) // test
}

// maybe less space in between cards?


// maybe use this as template for reg and favorites

// why when touch in middle skews to one side? here or card self?

// what if movie manager for api grab, but for this view just pass in which array for api ones or fav ones

