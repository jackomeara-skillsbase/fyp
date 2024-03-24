//
//  CommentsPopupView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 23/03/2024.
//

import SwiftUI

struct CommentsPopupView: View {
    var commentsLoaded: Bool = true
    var comments: [Comment]
    @State var newCommentText: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                if commentsLoaded {
                    // display comments count
                    Text("\(comments.count) comments")
                    
                    // display comments
                    ScrollView {
                        ForEach(comments, id: \.self) { comment in
                            CommentView(comment: comment)
                        }
                    }
                    
                    Spacer()
                    
                    // add comment
                    AddCommentView(commentText: $newCommentText)
                } else {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    CommentsPopupView(comments: [
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Steven Gerrard", comment: "Pay attention to your knees pointing inwards at the bottom of the movement."),
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Steven Gerrard", comment: "See the annotated image for more details"),
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Mo Salah", comment: "Thanks for the feedback - how should I fix this"),
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Steven Gerrard", comment: "👍🏻"),
    ])
}
