//
//  SportEventsProtocols.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

protocol SportEventsViewModelProtocol {
    func bind(to tableView: UITableView)
}

protocol SportEventsItemViewModelProtocol {
    var name: String { get }
    var place: String { get }
    var duration: String { get }
}
