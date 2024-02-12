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
    @State private var isCoach: Bool = false
    
    @EnvironmentObject private var store: Store
    @Environment(\.dismiss) var dismiss

    var body: some View {
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
                AuthenticationFormField(text: $name, title: "Full Name", placeholder: "Enter your name")
                AuthenticationFormField(text: $password, title: "Create Password", placeholder: "Enter your password", isSecureField: true)
                AuthenticationFormField(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                Toggle("Coach", isOn: $isCoach)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign in button
            Button {
                Task {
                    try await store.signUp(withEmail: email, password: password, name: name, isCoach: isCoach)
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
            
            // sign in button
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundStyle(Color(.systemBlue))
            }
        }
        
//        VStack {
//            Image(systemName: "person.crop.circle")
//                .font(.system(size: 100))
//                .foregroundColor(Color.theme.accent)
//                .padding(.bottom, 30)
//            
//
//            TextField("Name", text: $name)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal, 20)
//                .padding(.bottom, 10)
//
//            TextField("Email", text: $email)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .padding(.horizontal, 20)
//                .padding(.bottom, 10)
//
//            SecureField("Password", text: $password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal, 20)
//                .padding(.bottom, 10)
//
//            SecureField("Confirm Password", text: $confirmPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal, 20)
//                .padding(.bottom, 30)
//            
//
//            Button(action: {
//                // Handle sign-up logic here
//                // You can validate inputs, create a new user, etc.
//                print("Sign Up button tapped")
//            }) {
//                Text("Sign Up")
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
//        .navigationBarTitle("Sign Up", displayMode: .inline)
    }
}

#Preview {
    SignUpView()
}
