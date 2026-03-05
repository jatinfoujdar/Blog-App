//
//  ActionBottomBar.swift
//  IOS
//
//  Created by jatin foujdar on 06/03/26.
//

import UIKit

class ActionBottomBar: UIView{
    let searchButton = UIButton()
    let settingButton = UIButton()
    
    override init(frame: CGRect) {
        super.frame = frame
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = .white
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        
        searchButton.tintColor = .black
        settingButton.tintColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [searchButton, settingButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
