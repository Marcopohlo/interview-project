//
//  AppCoordinator.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    var didFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []
    
    func start() {}
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {}
    
    func pushCoordinator(_ coordinator: Coordinator) {
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }
        
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

final class AppCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let sportEventsCoordinator = SportEventsCoordinator(navigationController: navigationController)
        pushCoordinator(sportEventsCoordinator)
    }
}
