//
//  CoachReview.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import Foundation

struct CoachReview: Identifiable, Codable, Hashable {
    let id: String
    let date: Date
    let overall: Int
    let range: Int
    let form: Int
    let control: Int
    let comments: String
    
    init(id: String, date: Date, overall: Int, range: Int, balance: Int, control: Int, comments: String) {
        self.id = id
        self.date = date
        self.overall = overall
        self.range = range
        self.form = balance
        self.control = control
        self.comments = comments
    }
    
    init(id: String, date: Date, overall: Int, range: Int, form: Int, control: Int, comments: String) {
        self.id = id
        self.date = date
        self.overall = overall
        self.range = range
        self.form = form
        self.control = control
        self.comments = comments
    }
}
