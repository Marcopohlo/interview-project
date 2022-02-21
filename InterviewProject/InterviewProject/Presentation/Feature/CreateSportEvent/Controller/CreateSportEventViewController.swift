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
        
        self.title = "Create Sport Event"
//        setUpNavigationBarAppearance()
        setUpBarButtonItems()
    }
    
    deinit {
        print("create deinitialized")
    }
}

// MARK: - Setup
private extension CreateSportEventViewController {
//    func setUpNavigationBarAppearance() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//        appearance.backgroundColor = .blue
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navigationController?.navigationBar.barTintColor = .blue
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
//    }
    
    func setUpBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, handler: didTapSaveButton)
    }
}

// MARK: - Actions
private extension CreateSportEventViewController {
    func didTapCancelButton() {
        viewModel.cancel()
    }
    
    func didTapSaveButton() {
        viewModel.save()
    }
}
