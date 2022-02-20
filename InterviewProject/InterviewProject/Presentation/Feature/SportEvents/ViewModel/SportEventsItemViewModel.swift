//
//  SportEventsItemViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation

struct SportEventsItemViewModel: SportEventsItemViewModelProtocol, Hashable {
    // MARK: - Properties
    var name: String {
        event.name
    }
    var place: String {
        event.place
    }
    var duration: String {
        "\(event.duration) minutes"
    }
    private let event: SportEventsData
    
    // MARK: - Initializers
    init(event: SportEventsData) {
        self.event = event
    }
}
