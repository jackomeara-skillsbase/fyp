//
//  UploadAttemptView.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 20/03/2024.
//

import SwiftUI

struct UploadAttemptView: View {
    @EnvironmentObject var store: Store
    var recorder: Recorder
    var technique: Technique
    @State private var caption: String = ""
    @State var visibilityLevel: Int = 0
    @State var player: AVLooperPlayer? = nil
    
    func getPermissionLevel() -> Attempt.PermissionLevel {
        switch visibilityLevel {
        case 1: return Attempt.PermissionLevel.pub
        case 2: return Attempt.PermissionLevel.priv
        default: return Attempt.PermissionLevel.pub
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Back Squat")
                .foregroundStyle(.accent)
                .font(.headline)
            
            HStack(alignment: .top) {
                if let player = self.player {
                    CustomVideoPlayer(player: player)
                        .frame(width: 120, height: 250)
                } else {
                    VStack {
                     ProgressView()
                    }
                    .frame(width: 120, height: 250)
                }
                
                
                VStack {
                    TextField(text: $caption) {
                        Text("Add a caption...")
                            .foregroundStyle(.secondaryText)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                    )
                    .padding(.bottom)
                    
                    AttemptVisibilityView(visibilityLevel: $visibilityLevel)
                    
                }
            }
            
            Button {
                if let currentUser = store.currentUser, let video_url = recorder.video_url {
                    print("Local video url to upload file from is \(video_url)")
                    store.selectedTab = 0
                    let attempt = Attempt(
                        id: UUID().uuidString,
                        date: Date(),
                        caption: caption,
                        video_url: "",
                        imgs: [],
                        player_name: store.currentUser!.name,
                        player_id: store.currentUser!.id,
                        technique_name: technique.technique_name,
                        technique_id: technique.id,
                        permissions: getPermissionLevel(),
                        custom_permissions: nil,
                        ai_reviewed: false,
                        coach_reviewed: false
                    )
                    Task.detached {
                        do {
                            guard let videoURL = try await VideoDataService.uploadVideo(fileURL: video_url) else { return }
                            print("video uploaded")
                            let mainAttempt = Attempt(id: attempt.id, date: attempt.date, caption: attempt.caption, video_url: videoURL, imgs: attempt.imgs, player_name: attempt.player_name, player_id: attempt.player_id, technique_name: attempt.technique_name, technique_id: attempt.technique_id, permissions: attempt.permissions, custom_permissions: nil, ai_reviewed: false, coach_reviewed: false)
                            
                            try await AttemptDataService.createAttempt(attempt: mainAttempt)
                            print("attempt created")
                            if mainAttempt.technique_name == "Back Squat" {
                                SquatRecognizer().analyseSquat(from: video_url) { result in
                                    let review = AIReview(id: UUID().uuidString, date: Date(), range: result.range, control: result.control, form: result.form, attempt_id: mainAttempt.id, flagged: false, flagged_description: "")
                                    print("squat analysed")
                                    Task {
                                        try await AIReviewDataService.uploadAIReview(review: review)
                                        Task {
                                            try await NotificationDataService.createNotification(notification: Notification(id: UUID().uuidString, date: Date(), user_id: store.currentUser!.id, message: "AI Review Completed"))
                                        }
                                        try await AttemptDataService.confirmAIReview(attemptID: mainAttempt.id)
                                        print("ai review uploaded")
                                    }
                                }
                            }
                            
                        } catch {
                            print("DEBUG: Error creating attempt: \(error.localizedDescription)")
                        }
                    }
                }
            } label: {
                HStack {
                    Text("Upload")
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .disabled(visibilityLevel < 1 || visibilityLevel > 2 )
            
            Spacer()
        }
        .onAppear {
            Task {
                while recorder.video_url == nil {
                    try await Task.sleep(nanoseconds: 200_000_000)
                }
                self.player = AVLooperPlayer(url: recorder.video_url!)
                self.player?.play()
            }
        }
        .onDisappear {
            self.player?.pause()
            self.player = nil
        }
        .padding()
    }
}

//#Preview {
//    UploadAttemptView()
//}
