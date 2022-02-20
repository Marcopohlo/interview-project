//
//  StorageManagerProtocol.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

protocol StorageManagerProtocol {
    var type: StorageType { get }
    
    func start()
    func loadData() async throws -> [Storable]
    func saveEvent(_ event: Storable)
}
