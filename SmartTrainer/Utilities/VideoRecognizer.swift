//
//  VideoRecognizer.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/02/2024.
//

import Foundation
import AVFoundation
import Vision

class VideoRecognizer {
    let predictionWindow = 90
    
    func recognizeDepth(from url: URL) {}
    
    func getPoses(from assetURL: URL, completion: @escaping ([VNHumanBodyPose3DObservation]) -> Void) {
        var allPoses = [VNHumanBodyPose3DObservation]()
        let asset = AVAsset(url: assetURL)
        let request = VNDetectHumanBodyPose3DRequest { vnRequest, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            if let poseObservations = vnRequest.results as? [VNHumanBodyPose3DObservation] {
                allPoses.append(contentsOf: poseObservations)
                if allPoses.count == self.predictionWindow {
                    completion(allPoses)
                }
            }
        }
        do {
            let videoProcessor = VNVideoProcessor(url: assetURL)
            try videoProcessor.addRequest(request, processingOptions: VNVideoProcessor.RequestProcessingOptions())
            try videoProcessor.analyze(CMTimeRange(start: .zero, duration: CMTime(seconds: 3, preferredTimescale: .min)))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func makePrediction(posesWindow: [VNHumanBodyPose3DObservation]) 
//    -> MLFeatureProvider?
    {
        // prepare model input
        for pose in posesWindow {
            do {
                try print(pose.recognizedPoints(.all))
            } catch {
                print("Couldn't print recognised points: \(error.localizedDescription)")
            }
        }
    }
}
