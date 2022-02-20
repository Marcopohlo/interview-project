//
//  StorageRepositoryProtocol.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

protocol StorageRepositoryProtocol {
    func start()
    func loadData(from storageType: StorageType) async throws -> [SportEventsData]
    func saveEvent(_ event: SportEventsData)
}
