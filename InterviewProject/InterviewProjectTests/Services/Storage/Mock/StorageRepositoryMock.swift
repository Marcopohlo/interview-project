//
//  StorageRepositoryMock.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import Foundation
@testable import InterviewProject

final class StorageRepositoryMock: StorageRepositoryProtocol {
    var started = false
    var loadStorageTypes: [StorageType]?
    var saveStorageType: StorageType?
    var savedEvent: Storable?
        
    func start() {
        started = true
    }
    
    func loadData(from storageTypes: [StorageType]) async throws -> [Storable] {
        loadStorageTypes = storageTypes
        return [SportEventMock()]
    }
    
    func saveEvent(in storageType: StorageType, _ event: Storable) {
        saveStorageType = storageType
        savedEvent = event
    }
}
