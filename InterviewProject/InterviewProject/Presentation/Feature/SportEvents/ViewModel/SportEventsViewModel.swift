//
//  SportEventsViewModel.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsViewModel: SportEventsViewModelProtocol {
    // MARK: - Properties
    private let storageRepository: StorageRepositoryProtocol
    private var dataSource: UITableViewDiffableDataSource<Int, SportEvent>?
    
    var createSportEventHandler: (() -> Void)?
    var data: [SportEvent] = []
    
    // MARK: - Initializers
    init(storageRepository: StorageRepositoryProtocol) {
        self.storageRepository = storageRepository
    }
    
    // MARK: - Actions
    func bind(to tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, event -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SportEventsCell.reuseIdentifier, for: indexPath) as? SportEventsCell else {
                fatalError("Unable to Dequeue Weather Day Table View Cell")
            }

            let viewModel = SportEventsItemViewModel(event: event)
            cell.configure(with: viewModel)

            return cell
        }
    }
    
    func start() {
        fetchData()
    }
    
    func fetchData() {
        Task {
            do {
                let data = try await storageRepository.loadData(from: .server, .local)
                var snapshot = NSDiffableDataSourceSnapshot<Int, SportEvent>()
                snapshot.appendSections([0])
                snapshot.appendItems(data.compactMap { $0 as? SportEvent })
                
                await dataSource?.apply(snapshot, animatingDifferences: false)
            } catch {
                
            }
        }
    }
}
