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
        createSportEventView.nameTextField.addTarget(self, action: #selector(nameTextFieldEditingChanged(_:)), for: .editingChanged)
        createSportEventView.placeTextField.addTarget(self, action: #selector(placeTextFieldEditingChanged(_:)), for: .editingChanged)
    }
}

// MARK: - Actions
private extension CreateSportEventViewController {
    @objc func didTapCancelButton() {
        viewModel.didTapCancelButton()
    }
    
    @objc func didTapSaveButton() {
        viewModel.didTapSaveButton()
    }
    
    @objc func nameTextFieldEditingChanged(_ textField: UITextField) {
        guard let name = textField.text else {
            return
        }
        viewModel.nameTextFieldEditingChanged(name)
    }
    
    @objc func placeTextFieldEditingChanged(_ textField: UITextField) {
        guard let place = textField.text else {
            return
        }
        viewModel.placeTextFieldEditingChanged(place)
    }
}
