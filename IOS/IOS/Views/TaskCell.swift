//
//  TaskCell.swift
//  IOS
//
//  Created by jatin foujdar on 10/03/26.
//

import UIKit

class TaskCell : UITableViewCell {
    
    static let identifier = "TaskCell"
    
    var onCompleteTap: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✓", for: .normal)
        button.tintColor = .systemGreen
               return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(completeButton)
        completeButton.addTarget(self, action: #selector(didTapComplete), for: .touchUpInside)
        
    }
       
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            completeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            completeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: completeButton.leadingAnchor, constant: -10)
        ])
    }
       
    func configure(with task: Task) {
        titleLabel.text = task.title
        
        if task.isCompleted {
            titleLabel.textColor = .gray
        } else {
            titleLabel.textColor = .black
        }
    }
    
    @objc private func didTapComplete() {
        onCompleteTap?()
    }
}
