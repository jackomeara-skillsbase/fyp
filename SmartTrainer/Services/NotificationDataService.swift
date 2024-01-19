//
//  NotificationDataService.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 19/01/2024.
//

import Foundation
import Combine

class NotificationDataService {
    @Published var allNotifications: [Notification] = []
    
    var notificationSubscription: AnyCancellable?
    
    private struct NotificationResponse: Decodable {
        let data: [Notification]
    }
    
    init() {
        getNotifications()
    }
    
    func getNotifications() {
        guard let url = URL(string: "http://ec2-54-170-28-60.eu-west-1.compute.amazonaws.com:8080/fyp/items/relationship") else {return}
        let decoder = JSONDecoder()
        notificationSubscription = NetworkManager.download(url: url)
            .decode(type: NotificationResponse.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {
                [weak self] (response) in
                self?.allNotifications = response.data
                self?.notificationSubscription?.cancel()
            })
    }
}
