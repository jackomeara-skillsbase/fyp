//
//  Date.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 11/01/2024.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toTimeAgoString() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        if secondsAgo < 60 {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < 3600 {
            let minutes = secondsAgo / 60
            return "\(minutes) minutes ago"
        } else if secondsAgo < 86400 {
            let hours = secondsAgo / 3600
            return "\(hours) hours ago"
        } else if secondsAgo < 604800 {
            let days = secondsAgo / 86400
            return "\(days) days ago"
        } else {
            let weeks = secondsAgo / 604800
            return "\(weeks) weeks ago"
        }
    }
}
