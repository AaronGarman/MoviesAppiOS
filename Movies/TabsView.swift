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
    
    var body: some View {
        TabView {
            MoviesGridView()
                .tabItem {
                    Label("Theaters", systemImage: "movieclapper")
                }
                .environment(authManager) // also put sign out button on favs view? pass this in too
                .environment(favMoviesManager)
            
            MoviesGridView() // will be favs list later
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    TabsView()
        .environment(AuthManager())
}

// more space between icons and top?
// diff icons?

