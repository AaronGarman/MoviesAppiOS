//
//  AuthManager.swift
//  Movies
//
//  Created by Aaron Garman on 7/30/24.
//

import Foundation
import FirebaseAuth

@Observable
class AuthManager {

    var user: User? // store logged in user
   
    var userEmail: String? {
        user?.email
    }

    init() {
        // Persist login if current user exists
        user = Auth.auth().currentUser
    }

    func signUp(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                user = authResult.user
            } catch {
                print(error)
            }
        }

    }

    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                user = authResult.user
            } catch {
                print(error)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print(error)
        }
    }
}
