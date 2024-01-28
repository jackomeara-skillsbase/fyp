//
//  VideoPlayerView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import SwiftUI
import AVKit

struct Annotation: Identifiable {
    let id = UUID()
    let text: String
    let timestamp: TimeInterval
    let user: String
}

struct VideoPlayerView: View {
    // Video player properties
        @State private var player: AVPlayer?
        @State private var currentTime: TimeInterval = 0
        
        // Annotation properties
        @State private var annotations: [Annotation] = []
        @State private var newAnnotationText: String = ""
    
    func setupPlayer() {
            player = AVPlayer(url: Bundle.main.url(forResource: "back_squat", withExtension: "mp4")!)
            player?.play()
            
            // Add an observer for time updates
            player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { time in
                self.currentTime = time.seconds
            }
        }
    
    func addAnnotation() {
        guard !newAnnotationText.isEmpty else { return }
        
        let newAnnotation = Annotation(text: newAnnotationText, timestamp: currentTime, user: "Jack")
        annotations.append(newAnnotation)
        
        // Clear the text field after adding the annotation
        newAnnotationText = ""
    }
        
    var body: some View {
        VStack {
            // Video player
            VideoPlayer(player: player)
                .onAppear {
                    setupPlayer()
                }
                .onDisappear {
                    player?.pause()
                }
            
//            // Current time display
//            Text("Current Time: \(currentTime, specifier: "%.2f") seconds")
            
            // Annotations list
            List(annotations) { annotation in
                VStack(alignment: .leading) {
                    Text("\(annotation.user) at \(annotation.timestamp, specifier: "%.2f") seconds:")
                    Text(annotation.text)
                }
            }
            
            // Add annotation input
            HStack {
                TextField("Add comment...", text: $newAnnotationText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Add Comment") {
                    addAnnotation()
                }
                .padding()
            }
        }
    }
}

#Preview {
    VideoPlayerView()
}
