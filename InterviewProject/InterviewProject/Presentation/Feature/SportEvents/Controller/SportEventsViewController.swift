//
//  SportEventsViewController.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

final class SportEventsViewController: UIViewController {
    
    private let tableView = UITableView()
    
    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sport Events"

        // Do any additional setup after loading the view.
    }

}
