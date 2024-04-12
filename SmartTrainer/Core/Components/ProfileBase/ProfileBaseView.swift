//
//  ProfileBaseView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct ProfileBaseView: View {
    var user: User
    var isCurrentUser: Bool = true
    @State private var image: Image? = nil
    @State private var isImagePickerPresented = false
    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack {
            
            ZStack {
                    CirclePhotoView(url: user.image_url, size: 140)
                        .onTapGesture {
                            print(user.image_url)
                            print("photo tapped")
                            if isCurrentUser {
                                isImagePickerPresented.toggle()
                            }
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImage: self.$image, store: store)
                        }
                
                if isCurrentUser {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.blue)
                        .backgroundStyle(.white)
                        .offset(x: 45, y: 45)
                }
            }
            
            Text(user.name)
                .foregroundStyle(Color.theme.accent)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top)
            
            Text(user.email)
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
        }
    }
}

//#Preview {
//    Group {
//        ProfileBaseView(name: "Jack O'Meara", email: "jackomeara@gmail.com")
//        ProfileBaseView(name: "Kobe Bryant", email: "kobe@gmail.com", profilePhoto: "player")
//        ProfileBaseView(name: "Mo Salah", email: "mo-salah@hotmail.com", profilePhoto: "coach")
//    }
//}
