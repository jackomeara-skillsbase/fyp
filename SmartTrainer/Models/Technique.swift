//
//  Technique.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

struct Technique: Identifiable, Codable, Hashable {
    let id: String
    let technique_name: String
    let video_url: String
    let description: String
    let ai_model: String
    let thumbnail: String
    
    static var all: [Technique] {
        get async {
            do {
                let techniques = try await TechniqueDataService.fetchTechniques()
                return techniques
            } catch {
                return []
            }
        }
    }
}
