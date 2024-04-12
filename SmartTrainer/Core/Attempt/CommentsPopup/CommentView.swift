//
//  CommentView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import SwiftUI

struct CommentView: View {
    @EnvironmentObject private var store: Store
    var comment: Comment
    @State private var profile_image: String = ""
    
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
//        .onAppear {
//            if let currentUser = store.currentUser {
//                if currentUser.id == comment.user_id {
//                    self.profile_image = currentUser.image_url
//                }
//                else if currentUser.role == userRole.player {
//                    self.profile_image = store.coaches.filter { $0.id == comment.user_id }[0].image_url
//                }
//                else {
//                    self.profile_image = store.players.filter { $0.id == comment.user_id }[0].image_url
//                }
//            }
//            print(self.profile_image)
//        }
    }
}

#Preview {
    CommentView(comment: Comment(id: UUID().uuidString, media_id: "123", date: Date(), user_id: "213", user_name: "Steven Gerrard", comment: "Pay attention to your knees pointing inwards at the bottom of the movement."))
}
