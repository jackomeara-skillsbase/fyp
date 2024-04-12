//
//  AddCommentView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import SwiftUI

struct AddCommentView: View {
    @EnvironmentObject private var store: Store
    @Binding var commentText: String
    var media_id: String
    @Binding var comments: [Comment]
    var body: some View {
        HStack {
            TextField("Add comment...", text: $commentText, onCommit: {
                // Check if the return key is pressed
                if UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) {
                    Task {
                        let comment = Comment(id: UUID().uuidString, media_id: media_id, date: Date(), user_id: store.currentUser!.id, user_name: store.currentUser!.name, comment: commentText)
                        do {
                            try await CommentDataService.addComment(comment: comment)
                            comments.append(comment)
                        } catch {}
                    }
                }
            })
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
    AddCommentView(commentText: .constant(""), media_id: "", comments: .constant([]))
}
