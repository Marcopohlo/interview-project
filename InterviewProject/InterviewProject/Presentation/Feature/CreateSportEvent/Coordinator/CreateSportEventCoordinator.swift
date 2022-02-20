//
//  CreateSportEventCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import UIKit

final class CreateSportEventCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    func start() {
        let createSportEventViewModel = DIContainer.container.resolve(CreateSportEventViewModelProtocol.self)!
        let createSportEventViewController = DIContainer.container.resolve(CreateSportEventViewController.self, argument: createSportEventViewModel)!
        let createSportEventNavigationController = UINavigationController(rootViewController: createSportEventViewController)
        navigationController.topViewController?.present(createSportEventNavigationController, animated: true)
    }
}
