//
//  VideoFrameView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/01/2024.
//

import SwiftUI
import AVFoundation

struct VideoFrameView: View {
    let videoURL: URL
    let timestamp: CMTime
    
    @State private var extractedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = extractedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            extractImage()
        }
    }
    func extractImage() {
        let asset = AVURLAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true

        do {
            let cgImage = try imageGenerator.copyCGImage(at: timestamp, actualTime: nil)
            self.extractedImage = UIImage(cgImage: cgImage)
        } catch let error {
            print("Error generating image: \(error)")
        }
    }
}

#Preview {
    VideoFrameView(videoURL: Bundle.main.url(forResource: "squat_attempt", withExtension: "MOV")!, timestamp: CMTime(seconds: 2, preferredTimescale: 1))
}
