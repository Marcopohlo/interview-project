//
//  CreateSportEventCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import UIKit

final class CreateSportEventCoordinator: Coordinator {
    // MARK: - Properties
    let navigationController: UINavigationController
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    override func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.didFinish?(self)
    }
    
    override func start() {
        var createSportEventViewModel = DIContainer.container.resolve(CreateSportEventViewModelProtocol.self)!
        createSportEventViewModel.didCancelEventCreation = { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationController.dismiss(animated: true)
            self.didFinish?(self)
        }
        createSportEventViewModel.didSaveEvent = { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationController.dismiss(animated: true)
            self.didFinish?(self)
        }
        createSportEventViewModel.showAlert = { [weak self] in
            self?.showAlert()
        }
        
        let createSportEventViewController = DIContainer.container.resolve(CreateSportEventViewController.self, argument: createSportEventViewModel)!
        let createSportEventNavigationController = UINavigationController(rootViewController: createSportEventViewController)
        createSportEventNavigationController.presentationController?.delegate = self
        navigationController.present(createSportEventNavigationController, animated: true)
    }
}

// MARK: - Alert
private extension CreateSportEventCoordinator {
    func showAlert() {
        let alertController = UIAlertController(title: "Missing items", message: "Please fill all items", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController.presentedViewController?.present(alertController, animated: true)
    }
}
