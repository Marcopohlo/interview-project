//
//  SportEventsContainer.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation
import Swinject

struct SportEventsContainer {
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        container.register(SportEventsViewController.self) { _ in
            SportEventsViewController()
        }
    }
}
