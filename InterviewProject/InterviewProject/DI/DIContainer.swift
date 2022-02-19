//
//  DIContainer.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation
import Swinject

struct DIContainer {
    static let container = Container()
    
    func register() {
        let sportEvents = SportEventsContainer(container: Self.container)
        sportEvents.register()
    }
}
