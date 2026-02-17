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
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        
      viewControllers = [
       UINavigationController(rootViewController: homeViewController),
       UINavigationController(rootViewController: profileViewController)
      ]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
}
