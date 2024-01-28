//
//  CoachRowView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct CoachRowView: View {
    let coach: Coach
    var body: some View {
        HStack {
            CirclePhotoView(url: coach.image)
            Text(coach.name)
                .foregroundStyle(Color.theme.accent)
                .fontWeight(.bold)
                .font(.headline)
                .padding(.leading)
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    CoachRowView(coach: Coach(id: 123, name: "Roy Hodgson", email: "roy.hodgson@hotmail.com", image: "coach"))
}
