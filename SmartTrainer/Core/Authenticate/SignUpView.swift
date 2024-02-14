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
            RolePickerView(isCoach: $isCoach)
            
            // fields
            VStack(spacing: 24) {
                AuthenticationFormField(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .autocapitalization(.none)
                AuthenticationFormField(text: $name, title: "Full Name", placeholder: "Enter your name")
                AuthenticationFormField(text: $password, title: "Create Password", placeholder: "Enter your password", isSecureField: true)
                AuthenticationFormField(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
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
                    Text("SIGN UP")
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
        .padding(.top)
    }
}

#Preview {
    SignUpView()
}
