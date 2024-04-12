//
//  CacheManager.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 28/03/2024.
//

import Foundation
import SwiftUI

class CacheManager {
    static let shared = CacheManager()
    
    private init() {}
    
    func cacheVideo(url: URL, completion: @escaping (URL?) -> Void) {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let cachedURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        
        // check whether resource is in cache
        if FileManager.default.fileExists(atPath: cachedURL.path) {
            completion(cachedURL)
            return
        }
        
        // if not, download and cache
        print("DEBUG: downloading video as not cached")
        URLSession.shared.downloadTask(with: url) { (tempURL, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(httpResponse.statusCode)")
                return
            }
            // Check inferred type based on file extension
            if let suggestedFilename = response?.suggestedFilename {
                let fileExtension = (suggestedFilename as NSString).pathExtension
                print("Inferred file extension: \(fileExtension)")
            }
            
            guard let tempURL = tempURL, error == nil else {
                print("DEBUG: Error downloading resource: ", error ?? "Unknown error")
                completion(nil)
                return
            }
            
            do {
                print("tempURL: \(tempURL.absoluteString), cachedURL: \(cachedURL.absoluteString)")
                try FileManager.default.moveItem(at: tempURL, to: cachedURL)
                completion(cachedURL)
            } catch {
                print("DEBUG: Error moving item to cache: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func cacheImage(url: URL?) async -> UIImage? {
        do {
            guard let url else { return nil }
            // check if already cached
            if let cachedResponse = URLCache.shared.cachedResponse(for: .init(url: url)) {
                return UIImage(data: cachedResponse.data)
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // save returned img data into cache
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                
                guard let image = UIImage(data: data) else {
                    return nil
                }
                
                return image
            }
        } catch {
            print("DEBUG: Error downloading image: \(error)")
            return nil
        }
    }
    
    func deleteVideo(fileName: String) {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let cachedURL = cacheDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: cachedURL.path) {
            do {
                try FileManager.default.removeItem(atPath: cachedURL.path)
                print("Video deleted from cache")
            } catch {
                print("Error deleting video: \(error)")
            }
        } else {
            print("no file found at path")
        }
    }
}
