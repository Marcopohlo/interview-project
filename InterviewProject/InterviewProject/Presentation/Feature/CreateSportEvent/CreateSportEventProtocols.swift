//
//  CreateSportEventProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Combine
import Foundation

protocol CreateSportEventViewModelProtocol: AnyObject {
    var cancelEventCreationAction: PassthroughSubject<Void, Never> { get }
    var saveEventAction: PassthroughSubject<Void, Never> { get }
    var showAlertAction: PassthroughSubject<Void, Never> { get }
    var showActionSheetAction: PassthroughSubject<Void, Never> { get }
    
    func saveEvent(storageType: StorageType)
    func didTapCancelButton()
    func didTapSaveButton()
    func nameTextFieldEditingChanged(_ name: String)
    func placeTextFieldEditingChanged(_ place: String)
    
    func numberOfPickerComponents() -> Int
    func numberOfPickerRowsInComponent(_ component: Int) -> Int
    func titleForRow(_ row: Int, forComponent component: Int) -> String?
    func didSelectPickerRow(_ row: Int, inComponent component: Int)
}
