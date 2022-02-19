//
//  SportEventsCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    func start() {
        let sportEventViewController = DIContainer.container.resolve(SportEventsViewController.self)!
        navigationController.pushViewController(sportEventViewController, animated: true)
    }
}