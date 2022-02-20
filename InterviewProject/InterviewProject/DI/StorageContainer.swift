//
//  StorageContainer.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation
import Swinject

struct StorageContainer {
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func register() {
        container.register(StorageRepositoryProtocol.self) { _ in
            StorageRepository(managers: resolveManagers())
        }
        .inObjectScope(.container)
    }
}

// MARK: - Private
private extension StorageContainer {
    func resolveManagers() -> [StorageManagerProtocol] {
        [resolveFirebase(), resolveRealm()]
    }
    
    func resolveFirebase() -> FirebaseStorageManager {
        FirebaseStorageManager()
    }
    
    func resolveRealm() -> RealmStorageManager {
        RealmStorageManager()
    }
}
