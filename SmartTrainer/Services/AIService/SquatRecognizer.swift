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
        // check if squat video is <3 seconds
        let asset = AVURLAsset(url: assetURL)
        let duration = asset.duration
        let videoDuration = CMTimeGetSeconds(duration)
        if videoDuration <= 3 {
            //completion(.error(""))
        }
        
        // run pose estimation
        extractRelevantPoses(from: assetURL) { poses in
            var rangeResult: String?
            var controlResult: String?
            var formResult: String?
            
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.predictRange(inputMatrix: poses) { range in
                rangeResult = range
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.predictControl(inputMatrix: poses) { control in
                controlResult = control
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.predictForm(inputMatrix: poses) { form in
                formResult = form
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                if let rangeResult = rangeResult,
                   let controlResult = controlResult,
                   let formResult = formResult 
                {
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
                let allPosesMatrix: [MLMultiArray] = allPoses.map { try! $0.keypointsMultiArray() }
                if allPoses.count == self.predictionWindow {
                    let posesMultiArrays: [MLMultiArray] = allPoses.map { try! $0.keypointsMultiArray() }
                    let modelInput = MLMultiArray(concatenating: posesMultiArrays, axis: 0, dataType: .float32)
                    completion(modelInput)
                }
                
//                // count number of iterations to run
//                let iterations = 7
//                var counter: Int = 0
//                var confidenceScores: [Double] = [Double]()
//                confidenceScores.reserveCapacity(iterations)
//                
//                // run for each window (iterating by 0.5 seconds)
//                for i in 0..<iterations {
//                    let observationsWindow = allPoses[safe: (counter*45)..<((counter*45)+90)]
//                    let posesMatrix: [MLMultiArray] = observationsWindow.map { try! $0.keypointsMultiArray() }
//                    let inputMatrix: MLMultiArray = MLMultiArray(concatenating: posesMatrix, axis: 0, dataType: .float32)
//                    self.predictIsSquat(inputMatrix: inputMatrix, counter: i) { prediction, counter in
//                        confidenceScores[counter] = prediction
//                        counter += 1
//                        
//                        if counter == iterations {
//                            completion()
//                        }
//                    }
//                }
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
    
    private func extractRelevantPoses(from assetURL: URL, completion: @escaping (MLMultiArray) -> Void) {
        
        // extract all frames from video
        var allPoses = [VNHumanBodyPoseObservation]()
        let request = VNDetectHumanBodyPoseRequest { vnRequest, error in
            if let error = error {
                fatalError("Error extracting poses: \(error.localizedDescription)")
            }
            if let poseObservations = vnRequest.results as? [VNHumanBodyPoseObservation] {
                allPoses.append(contentsOf: poseObservations)
            }
        }
        do {
            let videoProcessor = VNVideoProcessor(url: assetURL)
            try videoProcessor.addRequest(request, processingOptions: VNVideoProcessor.RequestProcessingOptions())
            try videoProcessor.analyze(CMTimeRange(start: .zero, duration: AVURLAsset(url: assetURL).duration))
        } catch {
            fatalError(error.localizedDescription)
        }
        
        print(allPoses.count)
        
        // get number of windows to detect squat in
        var frameCounter: Int = 0
        var iterations: Int = 0
        while frameCounter < (allPoses.count - 90) {
            print("frameCounter: \(frameCounter), (allPoses.count-90): \(allPoses.count-90)")
            frameCounter += 15
            iterations += 1
        }
        frameCounter = 0
        
        // init best poses and confidence of them
        var relevantPoses: MLMultiArray? = nil
        var bestConfidence: Double = 0.0
        
        let poseDispatchGroup = DispatchGroup()
        
        for i in 0..<iterations {
            let observationsWindow = allPoses[safe: (i*15)..<((i*15)+90)]
            print("observations window has length \(observationsWindow.count)")
            if(observationsWindow.count != 90) {
                print("i: \(i), (i*15): \(i*15), ((i*15)+90): \((i*15)+90)")
            }
            let posesMatrix: [MLMultiArray] = observationsWindow.map { try! $0.keypointsMultiArray() }
            let inputMatrix: MLMultiArray = MLMultiArray(concatenating: posesMatrix, axis: 0, dataType: .float32)
            
            poseDispatchGroup.enter()
            print("adding work to dispatch group for iteration \(i)")
            self.predictIsSquat(inputMatrix: inputMatrix) { prediction in
                print("prediction for \(i) is \(prediction)")
                if prediction > bestConfidence {
                    bestConfidence = prediction
                    relevantPoses = inputMatrix
                }
                poseDispatchGroup.leave()
            }
        }
        
        poseDispatchGroup.notify(queue: .main) {
            if let relevantPoses = relevantPoses {
                print("best confidence was \(bestConfidence)%")
                completion(relevantPoses)
            }
        }
    }
    
    private func predictRange(inputMatrix: MLMultiArray, completion: @escaping (String) -> Void) {
        let model = try? SquatRangeModel(configuration: MLModelConfiguration())
        do {
            guard let prediction = try model?.prediction(input: SquatRangeModelInput(poses: inputMatrix)) else {
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
        let model = try? ControlClassifier(configuration: MLModelConfiguration())
        do {
            guard let prediction = try model?.prediction(input: ControlClassifierInput(poses: inputMatrix)) else {
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
        let footModel = try? FeetDistance(configuration: MLModelConfiguration())
        let kneeModel = try? KneeAlignment(configuration: MLModelConfiguration())
        do {
            guard let footPrediction = try footModel?.prediction(input: FeetDistanceInput(poses: inputMatrix)) else {
                fatalError("Couldn't make prediction for foot form")
            }
            guard let footClass = footPrediction.featureValue(for: "label") else {
                fatalError("Couldn't get feature values for foot form prediction")
            }
            guard let kneePrediction = try kneeModel?.prediction(input: KneeAlignmentInput(poses: inputMatrix)) else {
                fatalError("Couldn't make prediction for knee form")
            }
            guard let kneeClass = kneePrediction.featureValue(for: "label") else {
                fatalError("Couldn't get feature values for knee form prediction")
            }
            
            print("foot alignment: \(footClass.stringValue), knee alignment: \(kneeClass.stringValue)")
            
            var scoreInt: Int = 2
            if footClass.stringValue == "fail" {
                scoreInt -= 1
            }
            if kneeClass.stringValue == "fail" {
                scoreInt -= 1
            }
            
            var resultString: String
            switch scoreInt {
            case 2: resultString = "good"
            case 1: resultString = "average"
            default: resultString = "poor"
            }
        
            completion(resultString)
        } catch {
            fatalError("Error predicting range: \(error.localizedDescription)")
        }
    }
    
    private func predictIsSquat(inputMatrix: MLMultiArray, completion: @escaping (Double) -> Void) {
        print("running is squat prediction")
        let model = try? SquatOrNot(configuration: MLModelConfiguration())
        do {
            guard let prediction = try model?.prediction(input: SquatOrNotInput(poses: inputMatrix)) else {
                fatalError("Couldn't make prediction for squat detection")
            }
            // get confidence for squat => true
            completion(prediction.labelProbabilities["squat"]!)
        } catch {
            fatalError("Error predicting squat detection confidence: \(error.localizedDescription)")
        }
    }
}
