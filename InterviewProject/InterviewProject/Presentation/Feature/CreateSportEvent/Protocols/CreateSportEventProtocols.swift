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
    
    func cancel()
    func save()
}
