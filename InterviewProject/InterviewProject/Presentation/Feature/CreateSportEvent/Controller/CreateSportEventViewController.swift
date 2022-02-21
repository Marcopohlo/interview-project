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
        createSportEventView.textFieldDelegate = self
        createSportEventView.pickerDelegate = self
        createSportEventView.pickerDataSource = self
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

// MARK: - UITextFieldDelegate
extension CreateSportEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIPickerViewDelegate
extension CreateSportEventViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.titleForRow(row, forComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.didSelectPickerRow(row, inComponent: component)
    }
}

// MARK: - UIPickerViewDataSource
extension CreateSportEventViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberOfPickerComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfPickerRowsInComponent(component)
    }
}
