//
//  PreviewProvider.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    private init() {
        
    }
    
    let backSquat = Technique(id: UUID().uuidString, technique_name: "Back Squat", video_url: "back_squat", description: "Bodyweight squat, keeping hips and knees aligned.", ai_model: "N/A", thumbnail: "back_squat")
    
    let attempt = Attempt(
        id: "123",
        date: Date(),
        caption: "",
        video_url: "back_squat",
        imgs: [],
        player_name: "Barry Bonds",
        player_id: "12345", 
        technique_name: "Back Squat",
        technique_id: "12414",
        permissions: Attempt.PermissionLevel.priv,
        custom_permissions: nil,
        ai_reviewed: false,
        coach_reviewed: false
    )
    
}
