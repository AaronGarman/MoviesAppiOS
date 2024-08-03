//
//  FavMoviesManager.swift
//  Movies
//
//  Created by Aaron Garman on 7/31/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@Observable
class FavMoviesManager {

    var favMovies: [Movie] = []

    private let dataBase = Firestore.firestore()

    init() {
        getFavMovies()
    }

    func getFavMovies() {

        // Access the "Messages" collection group in Firestore and listen for any changes
        dataBase.collectionGroup("favMovies").addSnapshotListener { querySnapshot, error in

            // Get the documents for the messages collection (a document represents a message in this case)
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Map Firestore documents to Message objects
            let favMovies = documents.compactMap { document in
                do {

                    // Decode message document to your Message data model
                    return try document.data(as: Movie.self)
                } catch {
                    print("Error decoding document into movie: \(error)")
                    return nil
                }
            }
            
            self.favMovies = favMovies
        }
    }

    func saveFavMovie(movie: Movie) {
        do {

            // Create a message object
            //let movie = Movie(id: <#T##Int#>, title: <#T##String#>, releaseDate: <#T##String#>, overview: <#T##String#>, voteAverage: <#T##Double#>, posterPath: <#T##String#>, backdropPath: <#T##String#>)

            // Save the message to your Firestore database
            try dataBase.collection("favMovies").document().setData(from: movie)

        } catch {
            print("Error saving movie to Firestore: \(error)")
        }
    }
    
    func deleteFavMovie(movie: Movie) {
        let movieId = String(movie.id)

        dataBase.collection("favMovies").document(movieId).delete { error in
            if let error = error {
                print("Error deleting movie: \(error)")
            } else {
                print("Movie successfully deleted")
                //getMessages() // Optionally refresh the list
            }
        }
    }
}


// name fav movie vs just movie?

// will it save for every user all same list or diff?
