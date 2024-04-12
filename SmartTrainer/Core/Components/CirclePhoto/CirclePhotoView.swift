//
//  CirclePhotoView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct CirclePhotoView: View {
    var url: String
    var size: CGFloat = 60
    
    var body: some View {
        AsyncCachedImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.theme.accent.opacity(0.8), lineWidth: 2))
                .shadow(color: Color.theme.accent.opacity(0.4), radius: 10, x:0, y:0)
        } placeholder: {
            if url != "" {
                VStack {
                    ProgressView()
                }
                .frame(width: size, height: size)
                .overlay(Circle().stroke(Color.theme.accent.opacity(0.8), lineWidth: 2))
                .shadow(color: Color.theme.accent.opacity(0.4), radius: 10, x:0, y:0)
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
