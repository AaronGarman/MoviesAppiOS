//
//  MoviesResponse.swift
//  Movies
//
//  Created by Aaron Garman on 7/24/24.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]    // movie API endpoint returns array of movie objects
}

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    let posterPath: String
    let backdropPath: String
    
    // enum to convert snake case to camel case
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// maybe do data as optionals? unwrap in other views. flatmap for images? card n detail views - do as funcs any?
// hashable protocol no require func like example?
