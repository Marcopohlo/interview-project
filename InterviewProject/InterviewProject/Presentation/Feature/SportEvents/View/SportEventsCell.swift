//
//  SportEventsCell.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "SportEventsCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with viewModel: SportEventsItemViewModelProtocol) {
        nameLabel.text = viewModel.name
        placeLabel.text = viewModel.place
        durationLabel.text = viewModel.duration
    }
}

// MARK: - Layout
private extension SportEventsCell {
    func setupViews() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(placeLabel)
        contentView.addSubview(durationLabel)
    }
    
    func setupLayout() {
        nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1).isActive = true
        nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2).isActive = true
        contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 2).isActive = true
        
        placeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        
        contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: durationLabel.trailingAnchor, multiplier: 2).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: placeLabel.bottomAnchor, multiplier: 1).isActive = true
    }
}
