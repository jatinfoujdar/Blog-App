//
//  ReminderListViewController.swift
//  IOS
//
//  Created by jatin foujdar on 06/03/26.
//

import UIKit

class ReminderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    var tasks: [Task] = []
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.text = "My Day"
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lb
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    private let inputStack: UIStackView = {
           let sv = UIStackView()
           sv.axis = .horizontal
           sv.spacing = 10
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
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
    
           tasks = Task.load()
           setupInputStack()
           setupTableView()
           setupConstraints()
           
           inputField.delegate = self
           addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
          
       }
    
    
    
    private func setupInputStack() {
        
        view.addSubview(titleLabel)
          inputStack.addArrangedSubview(inputField)
          inputStack.addArrangedSubview(addButton)
          view.addSubview(inputStack)
      }
      
      private func setupTableView() {
          view.addSubview(tableView)
          tableView.dataSource = self
          tableView.delegate = self
          tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
      }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        inputStack.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)

        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            
            
            inputStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            inputField.heightAnchor.constraint(equalToConstant: 40),
            
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputStack.topAnchor, constant: -10)
        ])
    }


    
    
    @objc func addTask() {
        guard let text = inputField.text, !text.isEmpty else { return }
        let newTask = Task(
            id: UUID(),
            title: text,
            isCompleted: false
        )
        tasks.append(newTask)
        Task.save(tasks)
        tableView.reloadData()
        inputField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }

        let task = tasks[indexPath.row]
        cell.configure(with: task)
        
        cell.onCompleteTap = { [weak self] in
            guard let self = self else { return }

            self.tasks[indexPath.row].isCompleted.toggle()

            self.tableView.reloadRows(at: [indexPath], with: .automatic)

            Task.save(self.tasks)
        }

        return cell
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addTask()
        inputField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Task.save(tasks)
        }
    }
}
