//
//  SportEventsViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Combine
import Foundation

final class SportEventsViewModel: SportEventsViewModelProtocol {
    // MARK: - Properties
    private let storageRepository: StorageRepositoryProtocol
    
    private var storageTypes: [StorageType] = [.local, .server]
    
    let stateSubject: CurrentValueSubject<SportEventsViewState, Never>
    let dataSubject: CurrentValueSubject<[Storable], Never>
    let createSportEventAction: PassthroughSubject<Void, Never>
    let showAlertAction: PassthroughSubject<Void, Never>
    
    // MARK: - Initializers
    init(
        storageRepository: StorageRepositoryProtocol,
        stateSubject: CurrentValueSubject<SportEventsViewState, Never>,
        dataSubject: CurrentValueSubject<[Storable], Never>,
        createSportEventAction: PassthroughSubject<Void, Never>,
        showAlertAction: PassthroughSubject<Void, Never>
    ) {
        self.storageRepository = storageRepository
        self.stateSubject = stateSubject
        self.dataSubject = dataSubject
        self.createSportEventAction = createSportEventAction
        self.showAlertAction = showAlertAction
    }
    
    // MARK: - Actions
    func loadData() {
        stateSubject.send(.loading)
        fetchData()
    }
    
    func refresh() {
        fetchData()
    }
    
    func didTapCreateSportEventButton() {
        createSportEventAction.send()
    }
    
    func handleErrorState() {
        showAlertAction.send()
    }
    
    func didSelectSegment(storageTypes: [StorageType]) {
        self.storageTypes = storageTypes
        loadData()
    }
}

// MARK: - Private
private extension SportEventsViewModel {
    func fetchData() {
        Task {
            do {
                let data = try await self.storageRepository.loadData(from: self.storageTypes)
                dataSubject.send(data)
                stateSubject.send(.data(data.isEmpty))
            } catch {
                dataSubject.send([])
                stateSubject.send(.error)
            }
        }
    }
}
