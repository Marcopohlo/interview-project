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
        let event = SportEventsData(name: "Skok do dálky", place: "Praha", duration: 10)
        storage?.saveEvent(event)
    }
}
