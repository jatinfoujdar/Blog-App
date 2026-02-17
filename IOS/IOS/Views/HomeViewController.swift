//
//  HomeViewController.swift
//  IOS
//
//  Created by jatin foujdar on 15/02/26.
//

import UIKit


class HomeViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "🏠 Home"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
