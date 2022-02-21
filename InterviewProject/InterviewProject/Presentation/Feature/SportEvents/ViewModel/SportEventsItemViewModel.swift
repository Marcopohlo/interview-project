//
//  SportEventsItemViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

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
    var icon: UIImage? {
        event.isRemote ? UIImage(systemName: "cloud.fill") : UIImage(systemName: "externaldrive.fill")
    }
    var iconColor: UIColor {
        event.isRemote ? .systemCyan : .systemGray
    }
    private let event: SportEvent
    
    // MARK: - Initializers
    init(event: SportEvent) {
        self.event = event
    }
}
