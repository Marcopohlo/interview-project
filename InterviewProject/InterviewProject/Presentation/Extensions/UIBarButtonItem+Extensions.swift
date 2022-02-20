//
//  UIBarButtonItem+Extensions.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import UIKit

extension UIBarButtonItem {
    convenience init(
        systemItem: UIBarButtonItem.SystemItem,
        handler: @escaping () -> Void
    ) {
        self.init(
            systemItem: systemItem,
            primaryAction: UIAction(
                handler: { _ in
                    handler()
                }
            )
        )
    }
}
