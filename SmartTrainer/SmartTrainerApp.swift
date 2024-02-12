//
//  SmartTrainerApp.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SmartTrainerApp: App {
    @StateObject private var store: Store = Store()
    
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if store.userSession != nil {
                SmartTrainerTabView()
                    .environmentObject(store)
            } else {
                LogInView()
                    .environmentObject(store)
            }
        }
    }
}
