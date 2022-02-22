//
//  CreateSportEventProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

protocol CreateSportEventViewModelProtocol: AnyObject {
    var didCancelEventCreation: (() -> Void)? { get set }
    var didSaveEvent: (() -> Void)? { get set }
    var showAlert: (() -> Void)? { get set }
    var showActionSheet: (() -> Void)? { get set }
    
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
