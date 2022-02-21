//
//  SportEventsCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsCoordinator: Coordinator {
    // MARK: - Properties
    let navigationController: UINavigationController
    private weak var viewModel: SportEventsViewModelProtocol?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    override func start() {
        let sportEventsViewModel = DIContainer.container.resolve(SportEventsViewModelProtocol.self)!
        sportEventsViewModel.createSportEventHandler = { [self] in
            showCreateSportEventScreen()
        }
        viewModel = sportEventsViewModel
        
        let sportEventViewController = DIContainer.container.resolve(SportEventsViewController.self, argument: sportEventsViewModel)!
        navigationController.pushViewController(sportEventViewController, animated: true)
    }
}

// MARK: - Private
private extension SportEventsCoordinator {
    func showCreateSportEventScreen() {
        let createSportEventCoordinator = CreateSportEventCoordinator(navigationController: navigationController)
        pushCoordinator(createSportEventCoordinator)
    }
}
