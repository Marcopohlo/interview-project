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
    private let shouldThrow: Bool
    
    var started = false
    var savedEvent: Storable?
    var data: [Storable] = []
    var loadDataMethodCalled = false
    
    init(storageType: StorageType, shouldThrow: Bool = false) {
        self.type = storageType
        self.shouldThrow = shouldThrow
    }
    
    func start() {
        started = true
    }
    
    func loadData() async throws -> [Storable] {
        loadDataMethodCalled = true
        if shouldThrow {
            throw StorageError.unableToFetch
        } else {
            return data
        }
    }
    
    func saveEvent(_ event: Storable) {
        savedEvent = event
    }
}
