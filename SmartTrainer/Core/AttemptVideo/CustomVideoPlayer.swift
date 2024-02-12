//
//  CustomVideoPlayer.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 30/01/2024.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVLooperPlayer
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true
        controller.videoGravity = .resizeAspectFill
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

class AVLooperPlayer: AVQueuePlayer {
    private var looper: AVPlayerLooper!

    convenience override init(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        self.init(playerItem: playerItem)
        looper = AVPlayerLooper(player: self, templateItem: playerItem)
    }
}
