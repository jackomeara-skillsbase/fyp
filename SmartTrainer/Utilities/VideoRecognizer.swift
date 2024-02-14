//
//  VideoRecognizer.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/02/2024.
//

import Foundation
import AVFoundation
import Vision
import CoreML

class VideoRecognizer {
    let predictionWindow = 90
    let shape = [90, 3, 18]
    
    func recognizeDepth(from url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        getPoses(from: url) { [self] poses in
            let poses = poses.prefix(predictionWindow).map { x in x }
            guard let prediction = makePrediction(posesWindow: poses) else {
                fatalError("Couldn't make prediction")
            }
            guard let predictedClass = prediction.featureValue(for: "label") else {
                fatalError("Couldn't get feature values from prediction")
            }
            completion(.success(predictedClass.stringValue))
            
        }
        return
    }
    
    func getPoses(from assetURL: URL, completion: @escaping ([VNHumanBodyPoseObservation]) -> Void) {
        var allPoses = [VNHumanBodyPoseObservation]()
//        let asset = AVAsset(url: assetURL)
        let request = VNDetectHumanBodyPoseRequest { vnRequest, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            if let poseObservations = vnRequest.results as? [VNHumanBodyPoseObservation] {
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
    
    func makePrediction(posesWindow: [VNHumanBodyPoseObservation]) -> MLFeatureProvider? {
        let model = try? SquatDepthModel2(configuration: MLModelConfiguration())
        let posesMultiArrays: [MLMultiArray] = posesWindow.map { try! $0.keypointsMultiArray() }
        let modelInput = MLMultiArray(concatenating: posesMultiArrays, axis: 0, dataType: .float32)
        var prediction: MLFeatureProvider?
        do {
            prediction = try model?.prediction(input: SquatDepthModel2Input(poses: modelInput))
        } catch {
            fatalError(error.localizedDescription)
        }
        return prediction
    }
}
