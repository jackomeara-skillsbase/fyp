//
//  Technique.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/01/2024.
//

import Foundation

struct Technique: Identifiable, Codable {
    let id: String
    let techniqueName: String
    let videoURL: String
    let description: String
    let aiModel: String
    let thumbnail: String
}
