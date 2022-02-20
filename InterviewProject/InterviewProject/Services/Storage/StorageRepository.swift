//
//  StorageRepository.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

final class StorageRepository: StorageRepositoryProtocol {
    private let managers: [StorageManagerProtocol]
    
    init(managers: [StorageManagerProtocol]) {
        self.managers = managers
    }
    
    func start() {
        managers.forEach { $0.start() }
    }
    
    func loadData(from storageType: StorageType...) async throws -> [Storable] {
        let filteredManagers = managers.filter { storageType.contains($0.type) }
        
        var data: [Storable] = []
        try await filteredManagers.asyncForEach { data.append(contentsOf: try await $0.loadData()) }
        return data
    }
    
    func saveEvent(in storageType: StorageType, _ event: Storable) {
        let filteredManagers = managers.filter { $0.type == storageType }
        filteredManagers.forEach { $0.saveEvent(event) }
    }
}
