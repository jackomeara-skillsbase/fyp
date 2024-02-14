//
//  CirclePhotoView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct CirclePhotoView: View {
    let url: String
    var size: CGFloat = 60
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.theme.accent.opacity(0.8), lineWidth: 2))
                .shadow(color: Color.theme.accent.opacity(0.4), radius: 10, x:0, y:0)
        } placeholder: {
            if url != "" {
                ProgressView()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.theme.accent.opacity(0.8), lineWidth: 2))
                    .shadow(color: Color.theme.accent.opacity(0.4), radius: 10, x:0, y:0)
            }
        }
    }
}

#Preview {
    CirclePhotoView(url: "coach")
}
