//
//  VideoDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 07/02/2024.
//

import Foundation
import FirebaseStorage

class VideoDataService {
    static func uploadVideo(fileURL: URL) async throws -> String? {
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/videos/\(fileName)")
        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"
        
        do {
            let _ = try await ref.putFileAsync(from: fileURL, metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload video: \(error)")
            return nil
        }
    }
}
