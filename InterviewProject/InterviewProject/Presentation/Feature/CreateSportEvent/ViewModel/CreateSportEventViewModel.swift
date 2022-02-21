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
    
    var didCancelEventCreation: (() -> Void)?
    var didSaveEvent: (() -> Void)?
    var showAlert: (() -> Void)?
    var showActionSheet: (() -> Void)?
    
    private lazy var pickerItems: [([Int], String)] = {
        [
            (Array(0...24), "h"),
            (Array(0...59), "m"),
            (Array(0...59), "s")
        ]
    }()
    private var selectedItems: [Int] = [0, 0, 0]
    
    // MARK: - Initializers
    init(storageRepository: StorageRepositoryProtocol) {
        self.storageRepository = storageRepository
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
        didSaveEvent?()
    }
    
    func didTapCancelButton() {
        didCancelEventCreation?()
    }
    
    func didTapSaveButton() {
        guard name?.isEmpty == false, place?.isEmpty == false else {
            showAlert?()
            return
        }
        showActionSheet?()
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
