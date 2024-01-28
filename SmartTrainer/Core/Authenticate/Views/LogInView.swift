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
    @StateObject private var globalVM = GlobalViewModel.shared
    @EnvironmentObject private var vm: HomeViewModel

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
                // Handle login logic here
                // You can perform authentication, navigate to another view, etc.
                print("Login button tapped")
                if username == "player" && password == "Password" {
                    vm.role = "player"
                    vm.email = "mj@gmail.com"
                    vm.name = "Michael Jordan"
                    vm.authenticated = true
                } else if username == "coach" && password == "Password" {
                    vm.role = "coach"
                    vm.email = "jose_mourinho@gmail.com"
                    vm.name = "Jose Mourinho"
                    vm.authenticated = true
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
