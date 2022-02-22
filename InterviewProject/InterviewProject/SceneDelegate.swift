//
//  SceneDelegate.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let appCoordinator = AppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let diContainer = DIContainer()
        diContainer.register()
        
        let storageRepository = DIContainer.container.resolve(StorageRepositoryProtocol.self)!
        storageRepository.start()
        
        appCoordinator.start()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appCoordinator.rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

