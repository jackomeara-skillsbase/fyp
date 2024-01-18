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
            
            SearchBarView(promptText: "Enter a coach's email...", searchText: .constant(""))
            
            
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
