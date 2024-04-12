//
//  VideoResourceView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 26/03/2024.
//

import SwiftUI
import AVKit

struct VideoResourceView: View {
    @EnvironmentObject private var store: Store
    
    // popup states
    @State var showAI: Bool = false
    @State var showCoachReview: Bool = false
    @State var showComments: Bool = false
    @State var showDrawingView: Bool = false
    
    // declare attempt and player to be initialised
    var attempt: Attempt
    @State private var player: AVLooperPlayer? = nil
    @State var isPlaying: Bool = false
    @State var drawingFrame: UIImage?
    private var offlineMode: Bool = true
    @State var cachedURL: URL? = nil
    
    // create video player at init
    init(attempt: Attempt) {
//        self.player = AVLooperPlayer(url: (offlineMode ? Bundle.main.url(forResource: "IMG_7215", withExtension: "MOV")! : URL(string: attempt.video_url)!))
        self.attempt = attempt
    }
    
    func extractImage(completion: @escaping (UIImage?) -> Void) {
        if let player = player {
            let asset = AVAsset(url: cachedURL!)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.generateCGImagesAsynchronously(forTimes: [NSValue(time: player.currentTime())]) { _, cgImage, _, _, error in
                guard let cgImage = cgImage, error == nil else {
                    print("Error generating image: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                
                let uiImage = UIImage(cgImage: cgImage, scale: 1, orientation: .right)
                completion(uiImage)
            }
        }
    }
    
    var body: some View {
        if let currentUser = store.currentUser {
                ZStack {
                    // video player
                    if let player = player {
                        CustomVideoPlayer(player: player)
                            .containerRelativeFrame([.horizontal, .vertical])
                            .onTapGesture {
                                if isPlaying {
                                    player.pause()
                                } else {
                                    player.play()
                                }
                                isPlaying.toggle()
                            }
                            .onDisappear {
                                player.pause()
                            }
                    } else {
                        ProgressView()
                            .containerRelativeFrame([.horizontal, .vertical])
                    }
                    
                    // overlay items
                    VStack {
                        Spacer()
                        
                        HStack(alignment: .bottom) {
                            
                            // video details bottom left
                            VStack(alignment: .leading) {
                                Text(attempt.player_name)
                                    .fontWeight(.semibold)
                                Text(attempt.caption)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            
                            Spacer()
                            
                            // tool buttons on right
                            VStack(alignment: .center, spacing: 30) {
                                
                                // ai review popup button
                                PopupButton(showState: $showAI, symbol: "desktopcomputer")
                                    .sheet(isPresented: $showAI) {
                                        AIReviewView(attemptID: attempt.id)
                                            .environmentObject(store)
                                            .presentationDetents([.fraction(0.7)])
                                    }
                                
                                // coach review popup button
                                PopupButton(showState: $showCoachReview, symbol: "pencil.and.list.clipboard")
                                    .sheet(isPresented: $showCoachReview) {
                                        CoachReviewView(showPanel: $showCoachReview, attempt: attempt)
                                            .presentationDetents([.fraction(0.7)])
                                            .environmentObject(store)
                                    }
                                
                                // comments popup button
                                PopupButton(showState: $showComments, symbol: "message.fill")
                                    .sheet(isPresented: $showComments) {
                                        CommentsPopupView(media_id: attempt.video_url)
                                            .presentationDetents([.fraction(0.7)])
                                            .environmentObject(store)
                                    }
                                
                                // drawing popup button (only if coach)
                                if currentUser.role == userRole.coach {
                                    Button {
                                        extractImage() { image in
                                            if let image = image {
                                                drawingFrame = image
                                                showDrawingView = true
                                            } else {
                                                print("Failed to extract image")
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .foregroundStyle(.white)
                                            .shadow(color: .black, radius: 3)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 80)
                    }
                    .padding()
                    
                    // pause button layer
                    if !isPlaying {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 80, height: 100)
                            .foregroundStyle(Color.white)
                            .opacity(0.7)
                            .shadow(color: Color.gray, radius: 10)
                    }
                }
                .fullScreenCover(isPresented: $showDrawingView) {
                    DrawFeedbackView(attempt: attempt, frame: $drawingFrame, showScreen: $showDrawingView)
                        .environmentObject(store)
                }
                .onAppear {
                    DispatchQueue.main.async {
                        CacheManager.shared.cacheVideo(url: URL(string: attempt.video_url)!) { cachedURL in
                            if let cachedURL = cachedURL {
                                self.cachedURL = cachedURL
                                self.player = AVLooperPlayer(url: cachedURL)
                                self.player!.play()
                                self.isPlaying = true
                            }
                        }
                    }
                }
                .onDisappear {
                    self.isPlaying = false
                    self.player!.pause()
                    self.player = nil
                }
        }
    }
    
    struct PopupButton: View {
        @Binding var showState: Bool
        var symbol: String
        
        var body: some View {
            Button {
                showState.toggle()
            } label: {
                Image(systemName: symbol)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 3)
            }
        }
        
    }
}

struct VideoResourceView_Previews: PreviewProvider {
    static var previews: some View {
        VideoResourceView(attempt: self.dev.attempt)
    }
}
