//
//  CreateSportEventViewController.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import UIKit

final class CreateSportEventViewController: UIViewController {
    // MARK: - Properties
    private let createSportEventView = CreateSportEventView()
    private let viewModel: CreateSportEventViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: CreateSportEventViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func loadView() {
        view = createSportEventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

// MARK: - Setup
private extension CreateSportEventViewController {
    func setupViews() {
        self.title = "Create Sport Event"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapSaveButton))
    }
}

// MARK: - Actions
private extension CreateSportEventViewController {
    @objc func didTapCancelButton() {
        viewModel.cancel()
    }
    
    @objc func didTapSaveButton() {
        viewModel.save()
    }
}
