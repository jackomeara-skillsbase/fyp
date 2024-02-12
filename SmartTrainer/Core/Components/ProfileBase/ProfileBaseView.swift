//
//  ProfileBaseView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct ProfileBaseView: View {
    var name: String
    var email: String
    var profilePhoto: String = "none"
    @State private var image: Image? = nil
    @State private var isImagePickerPresented = false
    
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
                    .onTapGesture {
                        isImagePickerPresented.toggle()
                    }
//                    .sheet(isPresented: $isImagePickerPresented) {
//                        ImagePicker(selectedImage: self.$image)
//                    }
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
        ProfileBaseView(name: "Jack O'Meara", email: "jackomeara@gmail.com")
        ProfileBaseView(name: "Kobe Bryant", email: "kobe@gmail.com", profilePhoto: "player")
        ProfileBaseView(name: "Mo Salah", email: "mo-salah@hotmail.com", profilePhoto: "coach")
    }
}
