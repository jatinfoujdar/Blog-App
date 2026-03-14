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
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Home"
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        
        // Setup Search Controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search posts..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc private func searchButtonTapped() {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
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

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print("Searching for: \(text)")
        // Actual filtering logic would go here
    }
}
