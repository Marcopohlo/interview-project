//
//  StorageRepositoryProtocol.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

protocol StorageRepositoryProtocol {
    func start()
    func loadData(from storageTypes: [StorageType]) async throws -> [Storable]
    func saveEvent(in storageType: StorageType, _ event: Storable)
}
