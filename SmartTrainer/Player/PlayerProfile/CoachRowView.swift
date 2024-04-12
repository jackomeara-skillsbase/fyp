//
//  CoachRowView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct CoachRowView: View {
    let coach: User
    let status: String
    var body: some View {
        HStack {
            CirclePhotoView(url: coach.image_url)
            Text(coach.name)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.bold)
                .font(.headline)
                .padding(.leading)
            Spacer()
            Image(systemName: status == "accepted" ? "checkmark.circle.fill" : "clock.fill")
                .resizable()
                .foregroundStyle(status == "accepted" ? .green : .gray)
                .frame(width: 30, height: 30)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CoachRowView(coach: User(id: "123", name: "Roy Hodgson", email: "roy.hodgson@hotmail.com", role: userRole.coach, image_url: ""), status: "accepted")
}
