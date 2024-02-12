//
//  ToastView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 08/02/2024.
//

import SwiftUI

struct ToastView: View {
    var message: String
    var color: Color = Color(.systemBlue)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(color.opacity(0.7))
                .frame(height: 50)
            Text(message)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ToastView(message: "Request sent to coach@gmail.com")
}
