//
//  CreateSportEventViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

final class CreateSportEventViewModel: CreateSportEventViewModelProtocol {
    
    func save() {
        let storage = DIContainer.container.resolve(StorageRepositoryProtocol.self)
        let event = SportEvent(id: UUID().uuidString, name: "Skok do dálky", place: "Praha", duration: 10)
        storage?.saveEvent(in: .local, event)
    }
}
