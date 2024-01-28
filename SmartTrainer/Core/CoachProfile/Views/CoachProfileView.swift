//
//  CoachProfileView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import SwiftUI

struct CoachProfileView: View {
    @EnvironmentObject private var hvm: HomeViewModel
    var body: some View {
        VStack {
            ProfileBaseView(name: hvm.name, email: hvm.email)
            
            HStack {
                Spacer()
                VStack {
                    Text("Players")
                        .foregroundStyle(Color.theme.secondaryText)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 2)
                    Text("8")
                        .foregroundStyle(Color.theme.accent)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                VStack {
                    Text("To Review")
                        .foregroundStyle(Color.theme.secondaryText)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 2)
                    Text("16")
                        .foregroundStyle(Color.theme.accent)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                print("logging out..")
                hvm.authenticated = false
            }) {
                Text("Log Out")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

#Preview {
    CoachProfileView()
}
