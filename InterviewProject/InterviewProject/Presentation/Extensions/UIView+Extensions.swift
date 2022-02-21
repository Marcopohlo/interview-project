//
//  UIView+Extensions.swift
//  InterviewProject
//
//  Created by Marek Pohl on 21.02.2022.
//

import UIKit

extension UIView {
    func pinToEdges(of view: UIView) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
