//
//  StorageRepository.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

enum StorageError: Error {
    case unableToFetch
}

final class StorageRepository: StorageRepositoryProtocol {
    private let managers: [StorageManagerProtocol]
    
    init(managers: [StorageManagerProtocol]) {
        self.managers = managers
    }
    
    func start() {
        managers.forEach { $0.start() }
    }
    
    func loadData(from storageTypes: [StorageType]) async throws -> [Storable] {
        let filteredManagers = managers.filter { storageTypes.contains($0.type) }
        
        var data: [Storable] = []
        try await filteredManagers.asyncForEach {
            do {
                data.append(contentsOf: try await $0.loadData())
            } catch {
                if filteredManagers.count == 1 {
                    throw StorageError.unableToFetch
                }
            }
        }
        return data.sorted { $0.timestamp > $1.timestamp }
    }
    
    func saveEvent(in storageType: StorageType, _ event: Storable) {
        let manager = managers.first { $0.type == storageType }
        manager?.saveEvent(event)
    }
}
