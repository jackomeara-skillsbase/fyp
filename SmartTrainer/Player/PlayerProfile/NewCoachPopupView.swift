//
//  NewCoachPopupView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 10/01/2024.
//

import SwiftUI

struct NewCoachPopupView: View {
    @Binding var searchText: String
    @Binding var showPopup: Bool
    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Coach")
                    .foregroundStyle(Color.theme.accent)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                CircleButtonView(iconName: "xmark")
                    .onTapGesture {
                        showPopup = false
                    }
            }
            .padding(.horizontal)
            .padding(.top)
            
            /*SearchBarView(promptText: "Enter a coach's email...", searchText: .constant(""), type: "go")*/
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.theme.secondaryText)
                TextField("Enter a coach's email...", text: $searchText, onCommit: {
                    // Check if the return key is pressed
                    if UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) {
                        Task {
                            showPopup = false
                            let status = try await RelationshipDataService.requestCoach(coachEmail: searchText)
                            if status == "no_coach" {
                                await store.sendToast(type: .error, message: "👎 Coach not found.")
                            } else if status == "success" {
                                await store.sendToast(type: .success, message: "🎉 Coach request sent.")
                            } else {
                                await store.sendToast(type: .warning, message: "⚠️ Coach already connected.")
                            }
                        }
                    }
                })
                    .submitLabel(.go)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x:10)
                            .foregroundColor(Color.theme.accent)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                searchText = ""
                            },
                        alignment: .trailing
                    )
                    
            }
            .font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(
                        color: Color.theme.accent.opacity(0.15),
                        radius: 10, x:0.0, y:0.0
                    )
            )
            .padding()
            
            
        }
        .background(Color.theme.background)
        .cornerRadius(15)
        .padding()
        .frame(minHeight: 500)
    }
}

#Preview {
    NewCoachPopupView(searchText: .constant(""), showPopup: .constant(true))
}
