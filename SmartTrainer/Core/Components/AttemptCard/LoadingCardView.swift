//
//  LoadingCardView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 16/04/2024.
//

import SwiftUI

struct LoadingCardView: View {
    var body: some View {
        VStack {
            Text("Upload in Progress")
                .foregroundStyle(.accent)
            Spacer()
            ProgressView()
                .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x:0.0, y:0.0
                )
        )
    }
}

#Preview {
    LoadingCardView()
}
