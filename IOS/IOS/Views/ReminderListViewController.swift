//
//  ReminderListViewController.swift
//  IOS
//
//  Created by jatin foujdar on 06/03/26.
//

import UIKit

class ReminderListViewController: UIViewController, UITextFieldDelegate{
    
    var tasks: [Task] = []
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.text = "My Day"
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lb
    }()
    
    private let taskStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    private let inputStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    private let mainStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    private let verticalStack: UIStackView = {
           let sv = UIStackView()
           sv.axis = .vertical
           sv.spacing = 15
           sv.alignment = .fill
           sv.distribution = .fill
           return sv
       }()
    
    private let inputField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "New Task"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        return btn
    }()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        inputField.delegate = self
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    private func setupUI(){
        
        view.addSubview(verticalStack)
        
        inputStack.addArrangedSubview(inputField)
        inputStack.addArrangedSubview(addButton)
        
        let taskCard = createTaskCard(title: "Buy Milk")
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(taskCard)
        verticalStack.addArrangedSubview(inputStack)
        
       
        
        
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func createTaskCard(title: String) -> UIView {
        let card = UIView()
        card.backgroundColor = .systemGray5
        card.layer.cornerRadius = 10
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let checkButton = UIButton(type: .system)
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .black
        
        let hStack = UIStackView(arrangedSubviews: [label, checkButton])
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.alignment = .center
        hStack.distribution = .fill
        
        card.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -10),
            hStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -10)
        ])
        
        return card
    }
    
    
    @objc func addTask() {
           guard let text = inputField.text, !text.isEmpty else { return }
           let newCard = createTaskCard(title: text)
           verticalStack.insertArrangedSubview(newCard, at: verticalStack.arrangedSubviews.count - 1)
           inputField.text = ""
       }

       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           inputField.resignFirstResponder()
           return true
       }
}
