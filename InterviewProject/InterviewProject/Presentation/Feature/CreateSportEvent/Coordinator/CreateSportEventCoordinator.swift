//
//  CreateSportEventCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import UIKit

final class CreateSportEventCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private var viewModel: CreateSportEventViewModelProtocol?
    
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
        createSportEventViewModel.showActionSheet = { [weak self] in
            self?.showActionSheet()
        }
        viewModel = createSportEventViewModel
        
        let createSportEventViewController = DIContainer.container.resolve(CreateSportEventViewController.self, argument: createSportEventViewModel)!
        let createSportEventNavigationController = UINavigationController(rootViewController: createSportEventViewController)
        createSportEventNavigationController.presentationController?.delegate = self
        navigationController.present(createSportEventNavigationController, animated: true)
    }
}

// MARK: - UIAlertController
private extension CreateSportEventCoordinator {
    func showAlert() {
        let alertController = UIAlertController(title: "Missing items", message: "Please fill all items", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController.presentedViewController?.present(alertController, animated: true)
    }
    
    func showActionSheet() {
        let alertController = UIAlertController(title: "Which storage?", message: nil, preferredStyle: .actionSheet)
        let remoteAction = UIAlertAction(title: "Remote", style: .default) { [weak self] action in
            self?.viewModel?.saveEvent(storageType: .server)
        }
        let localAction = UIAlertAction(title: "Local", style: .default) { [weak self] action in
            self?.viewModel?.saveEvent(storageType: .local)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(remoteAction)
        alertController.addAction(localAction)
        alertController.addAction(cancelAction)
        navigationController.presentedViewController?.present(alertController, animated: true)
    }
}
