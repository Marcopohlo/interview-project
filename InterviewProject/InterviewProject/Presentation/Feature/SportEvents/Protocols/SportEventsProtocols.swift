//
//  SportEventsProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

protocol SportEventsViewModelProtocol: AnyObject {
    var createSportEventHandler: (() -> Void)? { get set }
    var showAlert: (() -> Void)? { get set }
    var stateDidChange: ((SportEventsViewState) -> Void)? { get set }
    
    func bind(to tableView: UITableView)
    func loadData()
    func refresh()
    func didTapCreateSportEventButton()
    func handleErrorState()
}

protocol SportEventsItemViewModelProtocol {
    var name: String { get }
    var place: String { get }
    var duration: String { get }
    var icon: UIImage? { get }
    var iconColor: UIColor { get }
}
