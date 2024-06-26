//
//  AttemptVisibilityView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 20/03/2024.
//

import SwiftUI

struct AttemptVisibilityView: View {
    @Binding var visibilityLevel: Int
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "globe.europe.africa.fill")
                    .resizable()
                    .foregroundStyle(visibilityLevel == 1 ? .accent : .secondaryText)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                Text("Public")
                    .foregroundStyle(visibilityLevel == 1 ? .accent : .secondaryText)
                    .font(.subheadline)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(visibilityLevel == 1 ? Color.blue : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                if visibilityLevel == 1 {
                    visibilityLevel = 0
                } else {
                    visibilityLevel = 1
                }
            }
            
            VStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundStyle(visibilityLevel == 2 ? .accent : .secondaryText)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                Text("Me")
                    .foregroundStyle(visibilityLevel == 2 ? .accent : .secondaryText)
                    .font(.subheadline)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(visibilityLevel == 2 ? Color.blue : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                if visibilityLevel == 2 {
                    visibilityLevel = 0
                } else {
                    visibilityLevel = 2
                }
            }
        }
    }
}

#Preview {
    AttemptVisibilityView(visibilityLevel: .constant(1))
}
