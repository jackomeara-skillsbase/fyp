//
//  Store.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/01/2024.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestoreSwift

@MainActor
class Store: ObservableObject {
    // firebase user auth data
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // init bool to load initial data
    @Published var isLoaded: Bool = false
    
    // model data
    @Published var attempts: [Attempt] = []
    @Published var players: [User] = []
    @Published var groups: [PlayersGroup] = []
    @Published var coaches: [Coach] = []
    @Published var notifications: [Notification] = []
    @Published var relationships: [Relationship] = []
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
            if let currentUser = self.currentUser {
                try await fetchAttempts()
                if currentUser.role == userRole.coach {
                    try await fetchPlayers()
                    // try await fetchGroups()
                }
                self.isLoaded = true
            }
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in: \(error.localizedDescription)")
        }
    }
    
    func signUp(withEmail email: String, password: String, name: String, role: userRole) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email, role: role, image_url: "")
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func fetchAttempts() async throws {
        if let currentUser = self.currentUser {
            if currentUser.role == userRole.coach {
                self.attempts = try await AttemptDataService.getAttemptsForCoach()
            } else {
                self.attempts = try await AttemptDataService.getAttemptsByPlayer()
            }
            self.attempts.sort { $0.date < $1.date }
        }
    }
    
    func fetchPlayers() async throws {
            self.players = try await UserDataService.fetchPlayers()
    }
    
    func fetchNotifications() async throws {
        if self.currentUser != nil {
            self.notifications = try await NotificationDataService.fetchNotifications()
        }
    }
    
    // inflate group members (array of ID's) to users
    func inflateGroupMembers(group: PlayersGroup) -> [User] {
        return self.players.filter {group.members.contains(Member(id: Int($0.id)!))}
    }
    
    func createAttempt(fileURL: URL, technique: Technique) async throws {
        if let currentUser = self.currentUser {
            do {
                // upload video first and get firebase file URL
                guard let videoURL = try await VideoDataService.uploadVideo(fileURL: fileURL) else { return }
                
                // create attempt object using firebase file URL
                let attempt = Attempt(id: UUID().uuidString,
                                      date: Date(),
                                      video_url: videoURL,
                                      player_name: currentUser.name,
                                      player_id: currentUser.id,
                                      technique_name: technique.techniqueName,
                                      technique_id: technique.id)
                try await AttemptDataService.createAttempt(attempt: attempt)
                
                // conduct AI review
                SquatRecognizer().analyseSquat(from: fileURL) { result in
                    let review = AIReview(id: NSUUID().uuidString, date: Date(), range: result.range, control: "", balance: "", attempt_id: attempt.id)
                    Task {
                        try await AIReviewDataService.uploadAIReview(review: review)
                    }
                }
            } catch {
                print("DEBUG: Couldn't create attempt with error: \(error.localizedDescription)")
            }
        }
    }
    
    func updateProfilePhoto(image: UIImage) async throws {
        do {
            // upload image first
            guard let fileURL = try await ImageDataService.uploadImage(image: image) else { return }
            
            // set url as image_url in user
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).updateData(["image_url": fileURL]) else { return }
        }
    }
}
