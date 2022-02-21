//
//  SportEventsProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

protocol SportEventsViewModelProtocol: AnyObject {
    var createSportEventHandler: (() -> Void)? { get set }
    var toggleLoader: ((Bool) -> Void)? { get set }
    
    func bind(to tableView: UITableView)
    func start()
    func refresh()
}

protocol SportEventsItemViewModelProtocol {
    var name: String { get }
    var place: String { get }
    var duration: String { get }
}
