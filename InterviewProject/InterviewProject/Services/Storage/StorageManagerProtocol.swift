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
    func loadData() async throws -> [SportEvent]
    func saveEvent(_ event: SportEvent)
}
