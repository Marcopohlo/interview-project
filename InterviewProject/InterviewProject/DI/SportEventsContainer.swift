//
//  SportEventsContainer.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Combine
import Foundation
import Swinject

struct SportEventsContainer {
    private let container: Container
    
    let cancelEventCreationAction: PassthroughSubject<Void, Never> = .init()
    let saveEventAction: PassthroughSubject<Void, Never> = .init()
    let showAlertAction: PassthroughSubject<Void, Never> = .init()
    let showActionSheetAction: PassthroughSubject<Void, Never> = .init()
    let stateSubject: CurrentValueSubject<SportEventsViewState, Never> = .init(.loading)
    let dataSubject: CurrentValueSubject<[Storable], Never> = .init([])
    let createSportEventAction: PassthroughSubject<Void, Never> = .init()
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        container.register(SportEventsViewModelProtocol.self) { resolver in
            SportEventsViewModel(
                storageRepository: resolver.resolve(StorageRepositoryProtocol.self)!,
                stateSubject: stateSubject,
                dataSubject: dataSubject,
                createSportEventAction: createSportEventAction,
                showAlertAction: showAlertAction
            )
        }
        
        container.register(SportEventsViewController.self) { _, viewModel in
            SportEventsViewController(viewModel: viewModel)
        }
        
        container.register(CreateSportEventViewModelProtocol.self) { resolver in
            CreateSportEventViewModel(
                storageRepository: resolver.resolve(StorageRepositoryProtocol.self)!,
                cancelEventCreationAction: cancelEventCreationAction,
                saveEventAction: saveEventAction,
                showAlertAction: showAlertAction,
                showActionSheetAction: showActionSheetAction
            )
        }
        
        container.register(CreateSportEventViewController.self) { _, viewModel in
            CreateSportEventViewController(viewModel: viewModel)
        }
    }
}
