//
//  StorageManagerMock.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import Foundation
@testable import InterviewProject

final class StorageManagerMock: StorageManagerProtocol {
    var type: StorageType
    var started = false
    var savedEvent: Storable?
    var data: [Storable] = [SportEventMock()]
    
    init(storageType: StorageType) {
        self.type = storageType
    }
    
    func start() {
        started = true
    }
    
    func loadData() async throws -> [Storable] {
        return data
    }
    
    func saveEvent(_ event: Storable) {
        savedEvent = event
    }
}
