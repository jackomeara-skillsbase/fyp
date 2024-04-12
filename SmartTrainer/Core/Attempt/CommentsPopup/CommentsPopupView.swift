//
//  CommentsPopupView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 23/03/2024.
//

import SwiftUI

struct CommentsPopupView: View {
    @EnvironmentObject private var store: Store
    var commentsLoaded: Bool = true
    var media_id: String
    @State var comments: [Comment] = []
    @State var newCommentText: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                if commentsLoaded {
                    // display comments count
                    Text("\(comments.count) comments")
                        .padding(.top)
                    
                    // display comments
                    ScrollView {
                        ForEach(comments, id: \.self) { comment in
                            CommentView(comment: comment)
                                .environmentObject(store)
                        }
                    }
                    
                    Spacer()
                    
                    // add comment
                    AddCommentView(commentText: $newCommentText, media_id: media_id, comments: $comments)
                        .environmentObject(store)
                } else {
                    ProgressView()
                }
            }
        }
        .onAppear {
            Task {
                do {
                    self.comments = try await CommentDataService.fetchCommentsForMedia(mediaID: media_id)
                } catch {
                    
                }
            }
        }
    }
}

#Preview {
    CommentsPopupView(media_id: "", comments: [
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Steven Gerrard", comment: "Pay attention to your knees pointing inwards at the bottom of the movement."),
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Steven Gerrard", comment: "See the annotated image for more details"),
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Mo Salah", comment: "Thanks for the feedback - how should I fix this"),
        Comment(id: UUID().uuidString, media_id: "12", date: Date(), user_id: "1234", user_name: "Steven Gerrard", comment: "👍🏻"),
    ])
}
