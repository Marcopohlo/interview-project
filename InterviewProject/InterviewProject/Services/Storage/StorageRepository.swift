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
    
    func loadData(from storageType: StorageType) async throws -> [SportEvent] {
        let filteredManagers = managers.filter { $0.type == storageType }
        
        var data: [SportEvent] = []
        try await filteredManagers.asyncForEach { data.append(contentsOf: try await $0.loadData()) }
        return data
    }
    
    func saveEvent(_ event: SportEvent) {
        managers.forEach { $0.saveEvent(event) }
    }
}
