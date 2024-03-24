//
//  SquatRecognizer.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 09/02/2024.
//

import Foundation
import AVFoundation
import Vision
import CoreML

struct AIPrediction {
    let range: String
    let control: String
    let form: String
}

class SquatRecognizer {
    let predictionWindow = 90
    let shape = [90, 3, 18]
    
    func analyseSquat(from assetURL: URL, completion: @escaping(AIPrediction) -> Void) {
        extractPoses(from: assetURL) { poses in
            var rangeResult: String?
            var controlResult: String?
            var formResult: String?
            
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.predictRange(inputMatrix: poses) { range in
                rangeResult = range
                dispatchGroup.leave()
            }
            
            self.predictControl(inputMatrix: poses) { control in
                controlResult = control
                dispatchGroup.leave()
            }
            
            self.predictForm(inputMatrix: poses) { form in
                formResult = form
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                if let rangeResult = rangeResult,
                   let controlResult = controlResult,
                   let formResult = formResult {
                    completion(AIPrediction(range: rangeResult, control: controlResult, form: formResult))
                }
            }
        }
    }
    
    private func extractPoses(from assetURL: URL, completion: @escaping (MLMultiArray) -> Void) {
        var allPoses = [VNHumanBodyPoseObservation]()
        let request = VNDetectHumanBodyPoseRequest { vnRequest, error in
            if let error = error {
                fatalError("Error extracting poses: \(error.localizedDescription)")
            }
            if let poseObservations = vnRequest.results as? [VNHumanBodyPoseObservation] {
                allPoses.append(contentsOf: poseObservations)
                if allPoses.count == self.predictionWindow {
                    let posesMultiArrays: [MLMultiArray] = allPoses.map { try! $0.keypointsMultiArray() }
                    let modelInput = MLMultiArray(concatenating: posesMultiArrays, axis: 0, dataType: .float32)
                    completion(modelInput)
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
    
    private func predictRange(inputMatrix: MLMultiArray, completion: @escaping (String) -> Void) {
        let model = try? SquatDepthModel2(configuration: MLModelConfiguration())
        do {
            guard let prediction = try model?.prediction(input: SquatDepthModel2Input(poses: inputMatrix)) else {
                fatalError("Couldn't make prediction for range")
            }
            guard let predictedClass = prediction.featureValue(for: "label") else {
                fatalError("Couldn't get feature values for range prediction")
            }
            completion(predictedClass.stringValue)
        } catch {
            fatalError("Error predicting range: \(error.localizedDescription)")
        }
    }
    
    private func predictControl(inputMatrix: MLMultiArray, completion: @escaping (String) -> Void) {
        let model = try? SquatDepthModel2(configuration: MLModelConfiguration())
        do {
            guard let prediction = try model?.prediction(input: SquatDepthModel2Input(poses: inputMatrix)) else {
                fatalError("Couldn't make prediction for control")
            }
            guard let predictedClass = prediction.featureValue(for: "label") else {
                fatalError("Couldn't get feature values for control prediction")
            }
            completion(predictedClass.stringValue)
        } catch {
            fatalError("Error predicting range: \(error.localizedDescription)")
        }
    }
    
    private func predictForm(inputMatrix: MLMultiArray, completion: @escaping (String) -> Void) {
        let model = try? SquatDepthModel2(configuration: MLModelConfiguration())
        do {
            guard let prediction = try model?.prediction(input: SquatDepthModel2Input(poses: inputMatrix)) else {
                fatalError("Couldn't make prediction for form")
            }
            guard let predictedClass = prediction.featureValue(for: "label") else {
                fatalError("Couldn't get feature values for form prediction")
            }
            completion(predictedClass.stringValue)
        } catch {
            fatalError("Error predicting range: \(error.localizedDescription)")
        }
    }
}
