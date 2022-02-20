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
        
        self.title = "Sport Events"
        setupButtons()
        bindViewModel()
    }
}

// MARK: - Layout
private extension SportEventsViewController {
    func setupButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .compose, handler: didTapCreateSportEventButton)
    }
}

// MARK: - Data bindings
private extension SportEventsViewController {
    func bindViewModel() {
        viewModel.bind(to: tableView)
    }
}

// MARK: - Actions
private extension SportEventsViewController {
    func didTapCreateSportEventButton() {
        viewModel.createSportEventHandler?()
    }
}
