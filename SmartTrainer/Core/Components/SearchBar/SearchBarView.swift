//
//  SearchBarView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI

struct SearchBarView: View {
    let promptText: String
    
    @Binding var searchText: String
    var type: String = "default"
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.secondaryText)
            TextField(promptText, text: $searchText)
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
}

#Preview {
    SearchBarView(promptText: "Search by exercise or user...", searchText: .constant(""))
}
