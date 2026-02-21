//
//  LoginViewController.swift
//  IOS
//
//  Created by jatin foujdar on 21/02/26.
//

import UIKit


class loginViewController : UIViewController{
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Login to your account"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let logininButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Login", for: .normal)
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
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logininButton)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
    
            // Email Field
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Password Field
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Login Button
            logininButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            logininButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logininButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logininButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
