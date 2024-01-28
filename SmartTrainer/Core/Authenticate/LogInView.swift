//
//  LogInView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import SwiftUI

struct LogInView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject private var store: Store

    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .font(.system(size: 100))
                .foregroundColor(Color.theme.accent)
                .padding(30)
            
            Spacer()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 30)

            Button(action: {
                print("Login button tapped")
                if username == "player" && password == "Password" {
                    store.role = "player"
                    store.email = "mj@gmail.com"
                    store.name = "Michael Jordan"
                    store.authenticated = true
                } else if username == "coach" && password == "Password" {
                    store.role = "coach"
                    store.email = "jose_mourinho@gmail.com"
                    store.name = "Jose Mourinho"
                    store.authenticated = true
                }
            }) {
                Text("Login")
                    .foregroundColor(Color.theme.background)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.theme.accent)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Login", displayMode: .inline)
    }
}

#Preview {
    LogInView()
}
