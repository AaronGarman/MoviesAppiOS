//
//  LoginView.swift
//  Movies
//
//  Created by Aaron Garman on 7/30/24.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AuthManager.self) var authManager

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color(.systemGray5)
                .ignoresSafeArea()
            
            // Vstack for title + image + fields Vstack and buttons Hstack
            VStack {
                Text("Movies App")
                    .font(.custom("American Typewriter", size: 44))
                Image("movie-clapper")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fill)
                
                // Vstack for email + password fields
                VStack {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .padding(EdgeInsets(top: 30, leading: 40, bottom: 40, trailing: 40))
            
                
                // Hstack for sign up + login buttons
                HStack {
                    Button("Sign Up") {
                        print("Sign up user: \(email), \(password)")
                        // will sign up user
                        authManager.signUp(email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    Button("Login") {
                        print("Login user: \(email), \(password)")
                        // will login user
                        authManager.signIn(email: email, password: password)
                    }
                    .buttonStyle(.bordered)
                    .tint(.black)
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthManager())
}

// more spacing between elements in code? compare w/ examples?

