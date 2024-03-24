//
//  ManagerProfileView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/03/2024.
//

import SwiftUI

struct ManagerProfileView: View {
    @EnvironmentObject private var store: Store
    var body: some View {
        if let currentUser = store.currentUser {
            VStack {
                ProfileBaseView(user: currentUser)
                    .environmentObject(store)
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Stat")
                            .foregroundStyle(Color.theme.secondaryText)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 2)
                        Text("0")
                            .foregroundStyle(Color.theme.accent)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                    VStack {
                        Text("Stat")
                            .foregroundStyle(Color.theme.secondaryText)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 2)
                        Text("0")
                            .foregroundStyle(Color.theme.accent)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                
                Spacer()
                
                Button(action: {
                    store.signOut()
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
}

#Preview {
    ManagerProfileView()
}
