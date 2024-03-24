//
//  AddCommentView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import SwiftUI

struct AddCommentView: View {
    @Binding var commentText: String
    var body: some View {
        HStack {
            TextField("Add comment...", text: $commentText)
                .submitLabel(.go)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(commentText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            commentText = ""
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
    AddCommentView(commentText: .constant(""))
}
