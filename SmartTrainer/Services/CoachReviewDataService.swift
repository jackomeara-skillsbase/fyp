//
//  CoachReviewDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 21/01/2024.
//

import Foundation
import Combine

class CoachReviewDataService {
    @Published var allCoachReviews: [CoachReview] = []
    
    var coachReviewSubscription: AnyCancellable?
    
    private struct CoachReviewResponse: Decodable {
        let data: [CoachReview]
    }
    
    init() {
        getCoachReviews()
    }
    
    func getCoachReviews() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/coach_review") else {return}
        let decoder = JSONDecoder()
        
        coachReviewSubscription = NetworkManager.download(url: url)
            .decode(type: CoachReviewResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (response) in
                self?.allCoachReviews = response.data
                self?.coachReviewSubscription?.cancel()
            })
    }
}
