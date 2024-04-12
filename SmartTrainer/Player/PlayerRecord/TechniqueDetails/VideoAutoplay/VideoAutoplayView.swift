//
//  VideoAutoplayView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 18/01/2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoAutoplayView: View {
    let videoFile: String
    var videoType: String = "mp4"
    var body: some View {
        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: videoFile, withExtension: videoType)!)) {
        }
        .onAppear {
            print("appear")
            AVPlayerManager.shared.play()
        }
        .onDisappear {
            print("disappear")
            AVPlayerManager.shared.pause()
        }
        .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
            // Video playback reached the end, seek back to the beginning for looping
            AVPlayerManager.shared.seekToBeginning()
            AVPlayerManager.shared.play()
        }
    }
}

class AVPlayerManager {
    static let shared = AVPlayerManager()
    
    private var player: AVPlayer?
    
    private init() {}
    
    func play() {
        guard let player = player else {
            return
        }
        player.play()
    }
    
    func pause() {
        guard let player = player else {
            return
        }
        player.pause()
    }
    
    func seekToBeginning() {
        guard let player = player else {
            return
        }
        player.seek(to: CMTime.zero)
    }
    
    func setPlayer(player: AVPlayer) {
        self.player = player
    }
}

#Preview {
    VideoAutoplayView(videoFile: "back_squat")
}

#Preview {
    VideoAutoplayView(videoFile: "squat_attempt", videoType: "MOV")
}
