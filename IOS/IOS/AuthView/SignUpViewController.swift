//
//  SignupView.swift
//  IOS
//
//  Created by jatin foujdar on 21/02/26.
//

import UIKit


class SignUpViewController: UIViewController {
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let nameTextField : UITextField = {
        
            let textField = UITextField()
            textField.placeholder = "Name"
            textField.borderStyle = .roundedRect
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let emailTextField : UITextField = {
            let textField = UITextField()
            textField.placeholder = "Email"
            textField.borderStyle = .roundedRect
            textField.autocapitalizationType = .none
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
            
        }()
    
    private let passwordTextField : UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signupButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
    
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad(){
        
        view.backgroundColor = .systemBackground
        
    }
    
    
    private func SetupUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupButton)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Email Field
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Password Field
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Signup Button
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

