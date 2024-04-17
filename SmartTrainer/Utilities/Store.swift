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
    
    @Published var commentMedia: String = ""
    @Published var showComments: Bool = false
    
    @Published var uploadingProgress: Double = -1
    
    // tab item manager view
    @Published var selectedTab: Int = 0
    
    // model data
    @Published var attempts: [Attempt] = []
    @Published var relationships: [Relationship] = []
    
    // toast message details
    @Published var currentToast: ToastMessage = ToastMessage(id: "", type: .info, message: "")
    @Published var toastMessage: String = ""
    @Published var showToast: Bool = false
    @Published var toastType: ToastType = .info
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
            if let currentUser = self.currentUser {
                self.isLoaded = true
            }
        }
    }
    
    func sendToast(type: ToastType, message: String) async {
        self.toastType = type
        self.toastMessage = message
        self.showToast = true
        do {
            try await Task.sleep(nanoseconds: 2*1_000_000_000)
            self.showToast = false
        }
        catch {}
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            self.isLoaded = true
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
            self.isLoaded = true
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
    
    func addDrawing(img: UIImage, attempt: Attempt) async throws -> String {
        if let currentUser = self.currentUser {
            do {
                guard let imageURL = try await ImageDataService.uploadImage(image: img) else { return "" }
                
                // update local array
//                let attemptIndex = self.attempts.firstIndex(where: {$0.id == attempt.id })
//                self.attempts[attemptIndex!].imgs.append(imageURL)
                
                // update attempt object
                try await AttemptDataService.addDrawing(attempt: attempt, imgURL: imageURL)
                return imageURL
            }
        }
        return ""
    }
    
    func createGroup(name: String, players: [String]) async throws -> PlayersGroup? {
        if let currentUser = currentUser {
            let group = PlayersGroup(id: UUID().uuidString, name: name, coach_id: currentUser.id, player_ids: players)
            try await GroupDataService.createGroup(group: group)
            return group
        }
        return nil
    }
    
    func updateGroupMembers(group: PlayersGroup, players: [String]) async throws {
        let group = PlayersGroup(id: group.id, name: group.name, coach_id: group.coach_id, player_ids: players)
        try await GroupDataService.updateGroup(group: group)
    }
    
    func updateProfilePhoto(image: UIImage) async throws {
        do {
            // upload image first
            guard let fileURL = try await ImageDataService.uploadImage(image: image) else { return }
            
            // set url as image_url in user
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).updateData(["image_url": fileURL]) else { return }
            self.currentUser?.image_url = fileURL
        }
    }
}
