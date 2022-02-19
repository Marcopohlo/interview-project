//
//  SportEventsCell.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsCell: UITableViewCell {
    
    static let reuseIdentifier = "SportEventsCell"
    
    private var viewModel: SportEventsItemViewModelProtocol?
    
    func configure(with viewModel: SportEventsItemViewModelProtocol) {
        self.viewModel = viewModel
    }
}
