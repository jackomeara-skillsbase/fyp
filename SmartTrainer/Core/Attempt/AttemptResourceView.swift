//
//  AttemptResource.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 31/01/2024.
//

import SwiftUI
import AVKit

struct AttemptResourceView: View {
    @State var isPlaying: Bool = false
    @State var showAI: Bool = false
    @State var showCoachReview: Bool = false
    @State var showComments: Bool = false
    private var player: AVLooperPlayer
    @EnvironmentObject private var store: Store
    @State var showDrawingView: Bool = false
    @State var drawingFrame: UIImage?
    var attempt: Attempt
    
    private var offlineMode: Bool = true
    
    init(attempt: Attempt) {
        self.player = AVLooperPlayer(url: (offlineMode ? Bundle.main.url(forResource: "IMG_7215", withExtension: "MOV")! : URL(string: attempt.video_url)!))
        self.attempt = attempt
    }
    
    func extractImage(completion: @escaping (UIImage?) -> Void) {
        let asset = AVAsset(url: (offlineMode ? Bundle.main.url(forResource: "IMG_7215", withExtension: "MOV")! : URL(string: attempt.video_url)!))
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
    
    var body: some View {
        if let currentUser = store.currentUser {
            if !showDrawingView {
                ZStack {
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
                    
                    VStack {
                        
                        Spacer()
                        
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text(attempt.player_name)
                                    .fontWeight(.semibold)
                                
                                Text(attempt.technique_name)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            
                            Spacer()
                            
                            VStack(spacing: 30) {
                                
                                CirclePhotoView(url: "", size: 64)
                                
                                Button {
                                    showAI.toggle()
                                } label: {
                                    Image(systemName: "desktopcomputer")
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                        .foregroundStyle(.white)
                                        .shadow(color: .black, radius: 3)
                                }
                                .sheet(isPresented: $showAI) {
                                    AIReviewView()
                                        .presentationDetents([.fraction(0.7)])
                                }
                                
                                Button {
                                    showCoachReview.toggle()
                                } label: {
                                    Image(systemName: "message.fill")
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                        .foregroundStyle(.white)
                                        .shadow(color: .black, radius: 3)
                                }
                                .sheet(isPresented: $showCoachReview) {
                                    CoachReviewView(showPanel: $showCoachReview, attempt: attempt)
                                        .presentationDetents([.fraction(0.7)])
                                        .environmentObject(store)
                                }
                                
                                Button {
                                    showComments.toggle()
                                } label: {
                                    Image(systemName: "message.fill")
                                        .resizable()
                                        .frame(width: 48, height: 48)
                                        .foregroundStyle(.white)
                                        .shadow(color: .black, radius: 3)
                                }
                                .sheet(isPresented: $showComments) {
                                    CommentsPopupView(comments: [])
                                        .presentationDetents([.fraction(0.7)])
                                        .environmentObject(store)
                                }
                                
                                if currentUser.role == userRole.coach {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .foregroundStyle(.white)
                                            .shadow(color: .black, radius: 3)
                                            .onTapGesture {
                                                self.player.pause()
                                                isPlaying = false
                                                extractImage() { image in
                                                    if let image = image {
                                                        showDrawingView = true
                                                        drawingFrame = image
                                                    } else {
                                                        print("Failed to extract image")
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .onAppear {
                        self.player.play()
                        isPlaying = true
                    }
                    
                    if !isPlaying {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 80, height: 100)
                            .foregroundStyle(Color.white)
                            .opacity(0.7)
                            .shadow(color: Color.gray, radius: 10)
                    }
                }
            } else {
                DrawFeedbackView(frame: drawingFrame, showScreen: $showDrawingView)
            }
        }
    }
}

#Preview {
    AttemptResourceView(attempt: Attempt(id: "123", date: Date(), video_url: "sadf", player_name: "Jack", player_id: "123", technique_name: "Bakc Squat", technique_id: "asd"))
        .environmentObject(Store())
}
