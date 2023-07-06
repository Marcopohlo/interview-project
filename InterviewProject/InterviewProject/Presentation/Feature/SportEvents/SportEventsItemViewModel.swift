//
//  SportEventsItemViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation

struct SportEventsItemViewModel: SportEventsItemViewModelProtocol {
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
    var iconName: String {
        event.isRemote ? "cloud.fill" : "externaldrive.fill"
    }
    var iconColor: Color {
        event.isRemote ? .cyan : .gray
    }
    
    enum Color {
        case cyan
        case gray
    }
    
    private let event: Storable
    
    // MARK: - Initializers
    init(event: Storable) {
        self.event = event
    }
}
