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
    private var state: SportEventsViewState = .loading {
        didSet {
            stateDidChange?(state)
        }
    }
    private var storageTypes: [StorageType] = [.local, .server]
    
    var createSportEventHandler: (() -> Void)?
    var showAlert: (() -> Void)?
    var stateDidChange: ((SportEventsViewState) -> Void)?
    
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
    
    func loadData() {
        state = .loading
        fetchData()
    }
    
    func refresh() {
        fetchData()
    }
    
    func didTapCreateSportEventButton() {
        createSportEventHandler?()
    }
    
    func handleErrorState() {
        showAlert?()
    }
    
    func didSelectSegment(storageTypes: [StorageType]) {
        self.storageTypes = storageTypes
        loadData()
    }
}

// MARK: - Private
private extension SportEventsViewModel {
    func fetchData() {
        Task {
            do {
                let data = try await storageRepository.loadData(from: storageTypes)
                DispatchQueue.main.async {
                    var snapshot = NSDiffableDataSourceSnapshot<Int, SportEvent>()
                    snapshot.appendSections([0])
                    snapshot.appendItems(data.compactMap { $0 as? SportEvent })
                    
                    self.dataSource?.apply(snapshot, animatingDifferences: false)
                    self.state = .data(data.isEmpty)
                }
            } catch {
                DispatchQueue.main.async {
                    let snapshot = NSDiffableDataSourceSnapshot<Int, SportEvent>()
                    self.dataSource?.apply(snapshot, animatingDifferences: false)
                    self.state = .error
                }
            }
        }
    }
}
