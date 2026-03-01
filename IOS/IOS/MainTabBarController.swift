//
//  MainTabBarController.swift
//  IOS
//
//  Created by jatin foujdar on 15/02/26.
//

import UIKit

class MainTabBarController : UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupTabBar()
    }
    
    private func SetupTabBar(){
        
        let profileViewController = ProfileViewController()
        let homeViewController = HomeViewController()
        let createViewController  = CreatePostViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        createViewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
      
        
        
      viewControllers = [
       UINavigationController(rootViewController: homeViewController),
       UINavigationController(rootViewController: createViewController),
       UINavigationController(rootViewController: profileViewController)
      ]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
}
