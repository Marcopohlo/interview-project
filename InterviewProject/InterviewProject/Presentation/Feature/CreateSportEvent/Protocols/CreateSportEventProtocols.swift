//
//  CreateSportEventProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation

protocol CreateSportEventViewModelProtocol {
    var didCancelEventCreation: (() -> Void)? { get set }
    var didSaveEvent: (() -> Void)? { get set }
    var showAlert: (() -> Void)? { get set }
    
    func didTapCancelButton()
    func didTapSaveButton()
    func nameTextFieldEditingChanged(_ name: String)
    func placeTextFieldEditingChanged(_ place: String)
}
