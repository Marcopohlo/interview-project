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
        activityIndicatorView.startAnimating()
        return activityIndicatorView
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
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        viewModel.start()
    }
}

// MARK: - Setup
private extension SportEventsViewController {
    func setupViews() {
        self.title = "Sport Events"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapCreateSportEventButton))
        tableView.register(SportEventsCell.self, forCellReuseIdentifier: SportEventsCell.reuseIdentifier)
    }
}

// MARK: - Data bindings
private extension SportEventsViewController {
    func bindViewModel() {
        viewModel.bind(to: tableView)
        viewModel.toggleLoader = { [weak self] toggle in
            self?.tableView.backgroundView = toggle ? self?.activityIndicatorView : nil
        }
    }
}

// MARK: - Actions
private extension SportEventsViewController {
    @objc func didTapCreateSportEventButton() {
        viewModel.createSportEventHandler?()
    }
}
