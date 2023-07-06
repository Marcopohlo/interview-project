//
//  SportEventsProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Combine
import Foundation

protocol SportEventsViewModelProtocol: AnyObject {
    var stateSubject: CurrentValueSubject<SportEventsViewState, Never> { get }
    var dataSubject: CurrentValueSubject<[Storable], Never> { get }
    var createSportEventAction: PassthroughSubject<Void, Never> { get }
    var showAlertAction: PassthroughSubject<Void, Never> { get }
    
    func loadData()
    func refresh()
    func didTapCreateSportEventButton()
    func handleErrorState()
    func didSelectSegment(storageTypes: [StorageType])
}

protocol SportEventsItemViewModelProtocol {
    var name: String { get }
    var place: String { get }
    var duration: String { get }
    var iconName: String { get }
    var iconColor: SportEventsItemViewModel.Color { get }
}
