//
//  ImageDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 08/02/2024.
//

import Foundation
import FirebaseStorage
import SwiftUI

class ImageDataService {
    static func uploadImage(image: UIImage) async throws -> String? {
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/images/\(fileName)")
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            print("Failed to convert image to data")
            return nil
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image")
            return nil
        }
    }
}
