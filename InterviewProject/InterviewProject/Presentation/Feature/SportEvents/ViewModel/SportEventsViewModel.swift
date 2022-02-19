//
//  SportEventsViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsViewModel: SportEventsViewModelProtocol {
    // MARK: - Properties
    private var dataSource: UITableViewDiffableDataSource<Int, SportEventsItemViewModel>?
    
    // MARK: - Actions
    func bind(to tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemViewModel -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SportEventsCell.reuseIdentifier, for: indexPath) as? SportEventsCell else {
                fatalError("Unable to Dequeue Weather Day Table View Cell")
            }

            cell.configure(with: itemViewModel)

            return cell
        }
    }
    
    func start() {
        
    }
}
