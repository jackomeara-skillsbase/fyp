//
//  ToastView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import SwiftUI

enum ToastType {
    case info, warning, success, error
}

struct ToastMessage: Equatable, Identifiable {
    let id: String
    let type: ToastType
    let message: String
}

struct ToastView: View {
    var type: ToastType
    var message: String
    
    func getColour() -> Color {
        switch(self.type) {
        case .info:
            return .blue
        case .warning:
            return .yellow
        case .success:
            return .green
        case .error:
            return .red
        }
    }
    
    var body: some View {
        HStack {
            Text(message)
                .foregroundStyle(.white)
                .padding()
                .bold()
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(getColour()))
        .padding()
    }
}

#Preview {
    VStack {
        ToastView(type: ToastType.info, message: "Info toast message.")
        ToastView(type: ToastType.warning, message: "Warning toast message.")
        ToastView(type: ToastType.error, message: "Error toast message.")
        ToastView(type: ToastType.success, message: "Success toast message.")
    }
}
