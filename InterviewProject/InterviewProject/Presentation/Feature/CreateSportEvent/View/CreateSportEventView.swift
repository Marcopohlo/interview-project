//
//  CreateSportEventView.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import UIKit

final class CreateSportEventView: UIView {
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.backgroundColor = .secondarySystemGroupedBackground
        stackView.layer.cornerCurve = .continuous
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        return nameTextField
    }()
    
    lazy var placeTextField: UITextField = {
        let placeTextField = UITextField()
        placeTextField.translatesAutoresizingMaskIntoConstraints = false
        placeTextField.placeholder = "Place"
        placeTextField.borderStyle = .roundedRect
        return placeTextField
    }()
    
    private lazy var pickerView = UIPickerView()
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            nameTextField.delegate = textFieldDelegate
            placeTextField.delegate = textFieldDelegate
        }
    }
    weak var pickerDelegate: UIPickerViewDelegate? {
        didSet {
            pickerView.delegate = pickerDelegate
        }
    }
    weak var pickerDataSource: UIPickerViewDataSource? {
        didSet {
            pickerView.dataSource = pickerDataSource
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGroupedBackground
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
private extension CreateSportEventView {
    func setupViews() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(placeTextField)
        stackView.addArrangedSubview(pickerView)
    }
    
    func setupLayout() {
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let keyboardConstraint = keyboardLayoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1)
        keyboardConstraint.priority = UILayoutPriority(999)
        keyboardConstraint.isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
