//
//  SportEventsViewController.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let viewModel: SportEventsViewModelProtocol
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.backgroundColor = .systemBackground
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .systemGray
        label.text = "No data"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    init(viewModel: SportEventsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        viewModel.loadData()
    }
}

// MARK: - Setup
private extension SportEventsViewController {
    func setupViews() {
        self.title = "Sport Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapCreateSportEventButton))
        self.extendedLayoutIncludesOpaqueBars = true
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(SportEventsCell.self, forCellReuseIdentifier: SportEventsCell.reuseIdentifier)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToEdges(of: view)
    }
}

// MARK: - Data bindings
private extension SportEventsViewController {
    func bindViewModel() {
        viewModel.bind(to: tableView)
        viewModel.stateDidChange = { [weak self] state in
            self?.handleStateChange(state: state)
        }
    }
}

// MARK: - Actions
private extension SportEventsViewController {
    @objc func didTapCreateSportEventButton() {
        viewModel.didTapCreateSportEventButton()
    }
    
    @objc func handleRefresh() {
        viewModel.refresh()
    }
}

// MARK: - State
private extension SportEventsViewController {
    func handleStateChange(state: SportEventsViewState) {
        switch state {
        case .loading:
            handleLoadingState()
        case .data(let isEmpty):
            handleDataState(isEmpty: isEmpty)
        case .error:
            handleErrorState()
        }
    }
    
    func handleLoadingState() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.pinToEdges(of: view)
    }
    
    func handleDataState(isEmpty: Bool) {
        tableView.refreshControl?.endRefreshing()
        activityIndicatorView.removeFromSuperview()
        if isEmpty {
            view.addSubview(noDataLabel)
            noDataLabel.pinToEdges(of: view)
        } else {
            noDataLabel.removeFromSuperview()
        }
    }
    
    func handleErrorState() {
        tableView.refreshControl?.endRefreshing()
        activityIndicatorView.removeFromSuperview()
        viewModel.handleErrorState()
    }
}
