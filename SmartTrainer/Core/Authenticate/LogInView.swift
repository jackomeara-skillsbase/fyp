//
//  LogInView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject private var store: Store
    
    var body: some View {
        NavigationStack {
            VStack {
                // some icon
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .frame(width:100, height: 120)
                    .padding(.vertical, 32)
                
                // fields
                VStack(spacing: 24) {
                    AuthenticationFormField(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    AuthenticationFormField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                Button {
                    Task {
                        try await store.logIn(withEmail:email, password:password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top)
                
                Spacer()
                
                // sign up button
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(store)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemBlue))
                }
                
            }
        }
        
        //        VStack {
        //            Image(systemName: "person.circle")
        //                .font(.system(size: 100))
        //                .foregroundColor(Color.theme.accent)
        //                .padding(30)
        //
        //            Spacer()
        //
        //            TextField("Username", text: $username)
        //                .textFieldStyle(RoundedBorderTextFieldStyle())
        //                .padding(.horizontal, 20)
        //                .padding(.bottom, 20)
        //
        //            SecureField("Password", text: $password)
        //                .textFieldStyle(RoundedBorderTextFieldStyle())
        //                .padding(.horizontal, 20)
        //                .padding(.bottom, 30)
        //
        //            Button(action: {
        //                print("Login button tapped")
        //                if username == "player" && password == "Password" {
        //                    store.role = "player"
        //                    store.email = "mj@gmail.com"
        //                    store.name = "Michael Jordan"
        //                    store.authenticated = true
        //                } else if username == "coach" && password == "Password" {
        //                    store.role = "coach"
        //                    store.email = "jose_mourinho@gmail.com"
        //                    store.name = "Jose Mourinho"
        //                    store.authenticated = true
        //                }
        //            }) {
        //                Text("Login")
        //                    .foregroundColor(Color.theme.background)
        //                    .padding()
        //                    .frame(maxWidth: .infinity)
        //                    .background(Color.theme.accent)
        //                    .cornerRadius(8)
        //            }
        //            .padding(.horizontal, 20)
        //
        //            Spacer()
        //        }
        //        .padding()
        //        .navigationBarTitle("Login", displayMode: .inline)
        //    }
    }
}

#Preview {
    LogInView()
}
