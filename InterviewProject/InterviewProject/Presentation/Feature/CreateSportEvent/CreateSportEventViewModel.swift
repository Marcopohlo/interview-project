//
//  CreateSportEventViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Combine
import Foundation

final class CreateSportEventViewModel: CreateSportEventViewModelProtocol {
    // MARK: - Properties
    private let storageRepository: StorageRepositoryProtocol
    private var name: String?
    private var place: String?
    private var duration: TimeInterval {
        selectedItems
            .enumerated()
            .map { enumerated -> TimeInterval in
                switch enumerated.offset {
                case 0: // Hours
                    return TimeInterval((enumerated.element * 60) * 60)
                case 1: // Minutes
                    return TimeInterval(enumerated.element * 60)
                case 2: // Seconds
                    return TimeInterval(enumerated.element)
                default:
                    return 0
                }
            }
            .reduce(0, +)
    }
    private var storageType: StorageType = .local
    
    let cancelEventCreationAction: PassthroughSubject<Void, Never>
    let saveEventAction: PassthroughSubject<Void, Never>
    let showAlertAction: PassthroughSubject<Void, Never>
    let showActionSheetAction: PassthroughSubject<Void, Never>
    
    private lazy var pickerItems: [([Int], String)] = {
        [
            (Array(0...23), "h"),
            (Array(0...59), "m"),
            (Array(0...59), "s")
        ]
    }()
    private var selectedItems: [Int] = [0, 0, 0]
    
    // MARK: - Initializers
    init(
        storageRepository: StorageRepositoryProtocol,
        cancelEventCreationAction: PassthroughSubject<Void, Never>,
        saveEventAction: PassthroughSubject<Void, Never>,
        showAlertAction: PassthroughSubject<Void, Never>,
        showActionSheetAction: PassthroughSubject<Void, Never>
    ) {
        self.storageRepository = storageRepository
        self.cancelEventCreationAction = cancelEventCreationAction
        self.saveEventAction = saveEventAction
        self.showAlertAction = showAlertAction
        self.showActionSheetAction = showActionSheetAction
    }
    
    // MARK: - Actions
    func saveEvent(storageType: StorageType) {
        guard let name = name, let place = place else {
            return
        }
        let event = SportEvent(
            id: UUID().uuidString,
            timestamp: Date.now.timeIntervalSince1970,
            name: name,
            place: place,
            duration: duration,
            isRemote: storageType == .server
        )
        storageRepository.saveEvent(in: storageType, event)
        saveEventAction.send()
    }
    
    func didTapCancelButton() {
        cancelEventCreationAction.send()
    }
    
    func didTapSaveButton() {
        guard name?.isEmpty == false, place?.isEmpty == false else {
            showAlertAction.send()
            return
        }
        showActionSheetAction.send()
    }
    
    func nameTextFieldEditingChanged(_ name: String) {
        self.name = name
    }
    
    func placeTextFieldEditingChanged(_ place: String) {
        self.place = place
    }
    
    // MARK: - UIPickerView
    
    func numberOfPickerComponents() -> Int {
        pickerItems.count
    }
    
    func numberOfPickerRowsInComponent(_ component: Int) -> Int {
        pickerItems[component].0.count
    }
    
    func titleForRow(_ row: Int, forComponent component: Int) -> String? {
        "\(pickerItems[component].0[row]) \(pickerItems[component].1)"
    }
    
    func didSelectPickerRow(_ row: Int, inComponent component: Int) {
        selectedItems[component] = pickerItems[component].0[row]
    }
}
