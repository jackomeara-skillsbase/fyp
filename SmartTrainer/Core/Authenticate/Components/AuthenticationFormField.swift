//
//  AuthenticationFormField.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 07/02/2024.
//

import SwiftUI

struct AuthenticationFormField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    AuthenticationFormField(text: .constant(""), title: "Email", placeholder: "name@gmail.com")
}
