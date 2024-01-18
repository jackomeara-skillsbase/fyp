//
//  ProfileBaseView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct ProfileBaseView: View {
    var name: String = "Jack O'Meara"
    var email: String = "jackomeara@gmail.com"
    var profilePhoto: String = "none"
    var body: some View {
        VStack {
            if profilePhoto == "none" {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(Color.theme.accent)
                    .frame(width:140, height:140)
                    .padding(.top, 50)
                    .shadow(
                        color: Color.theme.accent.opacity(0.25),
                        radius: 10, x:0.0, y:0.0
                    )
            } else {
                CirclePhotoView(url: profilePhoto, size: 140)
            }
            
            Text(name)
                .foregroundStyle(Color.theme.accent)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Text(email)
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
        }
    }
}

#Preview {
    Group {
        ProfileBaseView()
        ProfileBaseView(profilePhoto: "player")
        ProfileBaseView(profilePhoto: "coach")
    }
}
