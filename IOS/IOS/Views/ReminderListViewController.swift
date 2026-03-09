//
//  ReminderListViewController.swift
//  IOS
//
//  Created by jatin foujdar on 06/03/26.
//

import UIKit

class ReminderListViewController: UIViewController, UITextFieldDelegate{
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.text = "My Day"
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lb
    }()
    
    private let taskCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let taskLabel : UILabel = {
        let tl = UILabel()
        tl.text = "Buy Milk"
        tl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        tl.textColor = .gray
        return tl
    }()
    
    private let checkButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(systemName: "checkmark")
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private let inputField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "New Task"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.tintColor = .blue
        return btn
    }()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        
        inputField.delegate = self
        
        checkButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    private func setupUI(){
        view.addSubview(titleLabel)
        view.addSubview(taskCard)
        
        taskCard.addSubview(taskLabel)
        taskCard.addSubview(checkButton)
        
        view.addSubview(inputField)
        view.addSubview(addButton)
    }
    
    private func setupConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        taskCard.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
           
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            taskCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskCard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            taskCard.widthAnchor.constraint(equalToConstant: 220),
            taskCard.heightAnchor.constraint(equalToConstant: 100),
            
           
            taskLabel.centerYAnchor.constraint(equalTo: taskCard.centerYAnchor),
            taskLabel.leadingAnchor.constraint(equalTo: taskCard.leadingAnchor, constant: 20),
            
           
            checkButton.centerYAnchor.constraint(equalTo: taskCard.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: taskCard.trailingAnchor, constant: -20),
            
            inputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            inputField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            inputField.heightAnchor.constraint(equalToConstant: 40),

            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.centerYAnchor.constraint(equalTo: inputField.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func tappedButton(){
        taskLabel.textColor = .gray
        taskLabel.font = UIFont.italicSystemFont(ofSize: 18)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }
    
    @objc func addTask() {
        print(inputField.text ?? "")
    }
}
