//
//  MovieApiManager.swift
//  Movies
//
//  Created by Aaron Garman on 8/7/24.
//

import Foundation

@Observable
class MovieApiManager {
    // function to retrieve movie data from API
    
    var movies: [Movie] = []
    
    func fetchMovies() async {
        
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
