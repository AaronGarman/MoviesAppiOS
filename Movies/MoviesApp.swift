//
//  MoviesApp.swift
//  Movies
//
//  Created by Aaron Garman on 7/24/24.
//

import SwiftUI
import FirebaseCore

@main
struct MoviesApp: App {
    
    @State private var authManager: AuthManager
    @State private var favMoviesManager: FavMoviesManager
    @State private var movieApiManager: MovieApiManager
    
    init() {
        FirebaseApp.configure()
        authManager = AuthManager()
        favMoviesManager = FavMoviesManager()
        movieApiManager = MovieApiManager()
    }
    
    var body: some Scene {
        WindowGroup {
            if authManager.user != nil {
                // We have a logged in user, go to TabsView
                TabsView()
                    .environment(authManager)
                    .environment(favMoviesManager)
                    .environment(movieApiManager)
            } else {

                // No logged in user, go to LoginView
                LoginView()
                    .environment(authManager)
            }
        }
    }
}

