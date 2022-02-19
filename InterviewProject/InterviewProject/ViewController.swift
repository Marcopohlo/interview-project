//
//  ViewController.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("initialized")
        
        view.backgroundColor = .white
        
        let uiLabel = UILabel()
        uiLabel.textAlignment = .center
        uiLabel.frame = view.frame
        uiLabel.text = "Ahoj světe!"
        view.addSubview(uiLabel)
    }


}

