//
//  CommentView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import SwiftUI

struct CommentView: View {
    var comment: Comment
    var body: some View {
        HStack(alignment: .top) {
            CirclePhotoView(url: "", size: 40)
            
            VStack(alignment: .leading) {
                Text(comment.user_name)
                    .font(.caption)
                    .foregroundStyle(.accent)
                    .bold()
                
                Text(comment.comment)
                    .font(.subheadline)
                
                Text(comment.date.toTimeAgoString())
                    .font(.caption)
                    .foregroundStyle(.secondaryText)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    CommentView(comment: Comment(id: UUID().uuidString, media_id: "123", date: Date(), user_id: "213", user_name: "Steven Gerrard", comment: "Pay attention to your knees pointing inwards at the bottom of the movement."))
}
