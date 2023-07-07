//
//  SportEventsCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Combine
import UIKit

final class SportEventsCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private var cancellables: Set<AnyCancellable> = []
    private let reloadListAction: PassthroughSubject<Void, Never> = .init()
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    override func start() {
        let sportEventsViewModel = DIContainer.container.resolve(SportEventsViewModelProtocol.self)!
        sportEventsViewModel.createSportEventAction
            .sink { [weak self] in
                self?.showCreateSportEventScreen()
            }
            .store(in: &cancellables)
        
        sportEventsViewModel.showAlertAction
            .sink { [weak self] in
                self?.showAlert()
            }
            .store(in: &cancellables)
        
        reloadListAction
            .sink {
                sportEventsViewModel.loadData()
            }
            .store(in: &cancellables)
        
        let sportEventViewController = DIContainer.container.resolve(SportEventsViewController.self, argument: sportEventsViewModel)!
        navigationController.pushViewController(sportEventViewController, animated: true)
    }
}

// MARK: - Private
private extension SportEventsCoordinator {
    func showCreateSportEventScreen() {
        let createSportEventCoordinator = CreateSportEventCoordinator(
            navigationController: navigationController,
            reloadListAction: reloadListAction
        )
        pushCoordinator(createSportEventCoordinator)
    }
}

// MARK: - UIAlertController
private extension SportEventsCoordinator {
    func showAlert() {
        let alertController = UIAlertController(title: "Unable to fetch events", message: "Please try again later", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController.present(alertController, animated: true)
    }
}

