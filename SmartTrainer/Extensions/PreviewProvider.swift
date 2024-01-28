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
    
    let backSquat = Technique(id: UUID(), techniqueName: "Back Squat", videoURL: "back_squat", description: "Bodyweight squat, keeping hips and knees aligned.", aiModel: "N/A", thumbnail: "back_squat")
    
    let attempt = Attempt(id: 123, date: Date(), video_url: "back_squat", player_name: "Barry Bonds", player_id: "12345", technique_name: "Back Squat", technique_id: "12414", coach_review: 1, ai_review: "B")
}
