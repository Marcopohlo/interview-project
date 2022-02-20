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
        event.duration.asString(style: .positional)
    }
    private let event: SportEvent
    
    // MARK: - Initializers
    init(event: SportEvent) {
        self.event = event
    }
}
