//
//  ViewController.swift
//  IOS
//
//  Created by jatin foujdar on 14/02/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color
        view.backgroundColor = .white
        
        // Create a label
        let helloLabel = UILabel()
        helloLabel.text = "Hello World"
        helloLabel.textColor = .black
        helloLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        helloLabel.textAlignment = .center
        
        // Enable Auto Layout
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(helloLabel)
        
        // Center the label in the view
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

