//
//  SignUpView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 100))
                .foregroundColor(Color.theme.accent)
                .padding(.bottom, 30)
            

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 10)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            

            Button(action: {
                // Handle sign-up logic here
                // You can validate inputs, create a new user, etc.
                print("Sign Up button tapped")
            }) {
                Text("Sign Up")
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
        .navigationBarTitle("Sign Up", displayMode: .inline)
    }
}

#Preview {
    SignUpView()
}
