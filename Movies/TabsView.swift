//
//  TabsView.swift
//  Movies
//
//  Created by Aaron Garman on 7/29/24.
//

import SwiftUI

struct TabsView: View {
    
    @Environment(AuthManager.self) var authManager
    @Environment(FavMoviesManager.self) var favMoviesManager
    @Environment(MovieApiManager.self) var movieApiManager
    
    var body: some View {
        TabView {
            MoviesGridView(isNowPlaying: true)
                .tabItem {
                    Label("Theaters", systemImage: "movieclapper")
                }
                .environment(authManager) // also put sign out button on favs view? pass this in too
                .environment(favMoviesManager)
                .environment(movieApiManager)
            
            MoviesGridView(isNowPlaying: false) // will be favs list later
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    TabsView()
        .environment(AuthManager())
        .environment(FavMoviesManager())
        .environment(MovieApiManager())
}

// more space between icons and top?
// diff icons?

