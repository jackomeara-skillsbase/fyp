//
//  AttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

// display tiktok-style video overlay with buttons for ai review, coach review, drawing (if coach)
// can scroll to view drawings if they exist.

import SwiftUI

struct AttemptFeedView: View {
    @EnvironmentObject var store: Store
    @State var attempt: Attempt
    
    init(attempt: Attempt) {
        _attempt = State(initialValue: attempt)
    }
    
    var body: some View {
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    VideoResourceView(attempt: $attempt)
                        .environmentObject(store)
                    ForEach(attempt.imgs, id: \.self) { image in
                        ImageResourceView(imageURL: image)
                            .environmentObject(store)
                    }
                }
                .scrollTargetLayout()
            }
            .sheet(isPresented: $store.showComments) {
                CommentsPopupView(media_id: store.commentMedia)
                    .presentationDetents([.fraction(0.7)])
                    .environmentObject(store)
            }
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea()
    }
}

struct AttemptFeedView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptFeedView(attempt: self.dev.attempt)
    }
}
