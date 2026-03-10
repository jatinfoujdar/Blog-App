//
//  CreatePostViewController.swift
//  IOS
//
//  Created by jatin foujdar on 02/03/26.
//

import UIKit

class CreatePostViewController : UIViewController {
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let subtitleTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Subtitle"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let contentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.blue.cgColor
        tv.layer.cornerRadius = 5
        tv.font = .systemFont(ofSize: 14)
        return tv
    }()
    
    private let categorySegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Tech", "SwiftUI", "UIKit", "Apple", "IOS"])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create Post"
        
        setupNavigationBar()
        setupLayout()
    }
    
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Publish",
            style: .prominent,
            target: self,
            action: #selector(didTapPublish)
        )
    }
    
    private func setupLayout() {
         
         let stack = UIStackView(arrangedSubviews: [
             titleTextField,
             subtitleTextField,
             categorySegmentedControl,
             contentTextView
         ])
         
         stack.axis = .vertical
         stack.spacing = 16
         
         view.addSubview(stack)
         stack.translatesAutoresizingMaskIntoConstraints = false
         
         contentTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
         
         NSLayoutConstraint.activate([
             stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
         ])
     }
    
    @objc private func didTapPublish() {
        
        guard let title = titleTextField.text, !title.isEmpty,
              let subtitle = subtitleTextField.text, !subtitle.isEmpty,
              let content = contentTextView.text, !content.isEmpty
        else {
            showAlert(title: "Error", message: "All fields are required")
            return
        }
        
        let categories = ["Tech", "Lifestyle", "Travel"]
        let selectedCategory = categories[categorySegmentedControl.selectedSegmentIndex]
        
        let request = CreatePostRequest(
            title: title,
            subtitle: subtitle,
            content: content,
            category: selectedCategory
        )
        
        APIService.shared.createPost(request: request) { [weak self] result in
            switch result {
            case .success(let message):
                self?.showSuccessAlert(message: message)
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Alerts
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(
            title: "Success",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
}

