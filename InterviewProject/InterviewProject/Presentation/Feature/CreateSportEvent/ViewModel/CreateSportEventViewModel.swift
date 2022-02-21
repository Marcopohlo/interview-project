//
//  CreateSportEventViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

final class CreateSportEventViewModel: CreateSportEventViewModelProtocol {
    // MARK: - Properties
    private let storageRepository: StorageRepositoryProtocol
    private var name: String?
    private var place: String?
    private var duration: TimeInterval?
    private var storageType: StorageType = .local
    
    var didCancelEventCreation: (() -> Void)?
    var didSaveEvent: (() -> Void)?
    var showAlert: (() -> Void)?
    
    // MARK: - Initializers
    init(storageRepository: StorageRepositoryProtocol) {
        self.storageRepository = storageRepository
    }
    
    // MARK: - Actions
    func didTapCancelButton() {
        didCancelEventCreation?()
    }
    
    func didTapSaveButton() {
        guard
            let name = name, !name.isEmpty,
            let place = place, !place.isEmpty,
            let duration = duration
        else {
            showAlert?()
            return
        }

        let event = SportEvent(id: UUID().uuidString, name: name, place: place, duration: duration)
        storageRepository.saveEvent(in: storageType, event)
        didSaveEvent?()
    }
    
    func nameTextFieldEditingChanged(_ name: String) {
        self.name = name
    }
    
    func placeTextFieldEditingChanged(_ place: String) {
        self.place = place
    }
}
