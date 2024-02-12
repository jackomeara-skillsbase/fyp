//
//  FeedView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 30/01/2024.
//

import SwiftUI
import AVKit

struct FeedView: View {
    @State private var scrollPosition: String?
    @State private var player = AVPlayer()
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0 ..< 10) { post in
                    AttemptVideoView(post: post)
                        .id(post)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onChange(of: scrollPosition) { oldVal, newVal in
            
        }
    }
    
    func playVideoOnChangeOfScrollPos(postID: String) {
        
    }
}

#Preview {
    FeedView()
}
