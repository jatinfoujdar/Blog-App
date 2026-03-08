//
//  ReminderListViewController.swift
//  IOS
//
//  Created by jatin foujdar on 06/03/26.
//

import UIKit

class ReminderListViewController: UICollectionViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout{
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
