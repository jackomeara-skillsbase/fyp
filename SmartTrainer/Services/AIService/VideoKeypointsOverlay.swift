//
//  VideoKeypointsOverlay.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 24/03/2024.
//

import Foundation
import Vision
import SwiftUI

class VideoKeypointsOverlay {
    static func extractImageKeypoints(from image: UIImage) ->
    [VNRecognizedPoint]? {
        if let cgImage = image.cgImage {
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)
            let request = VNDetectHumanBodyPoseRequest()
            
            do {
                try requestHandler.perform([request])
                if let observation = request.results?.first {
                    let points = try observation.recognizedPoints(.all)
                    return [points[.neck]!, points[.leftHip]!, points[.rightHip]!]
                }
            } catch {
                print("DEBUG: Error extracting image keypoints: \(error.localizedDescription)")
            }
            
        }
        return nil
    }
}
