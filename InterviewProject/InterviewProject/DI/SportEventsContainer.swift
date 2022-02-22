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
        container.register(SportEventsViewModelProtocol.self) { resolver in
            SportEventsViewModel(storageRepository: resolver.resolve(StorageRepositoryProtocol.self)!)
        }
        
        container.register(SportEventsViewController.self) { _, viewModel in
            SportEventsViewController(viewModel: viewModel)
        }
        
        container.register(CreateSportEventViewModelProtocol.self) { resolver in
            CreateSportEventViewModel(storageRepository: resolver.resolve(StorageRepositoryProtocol.self)!)
        }
        
        container.register(CreateSportEventViewController.self) { _, viewModel in
            CreateSportEventViewController(viewModel: viewModel)
        }
    }
}
