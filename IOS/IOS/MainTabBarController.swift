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
        let remindersViewController = ReminderListViewController()
        
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        createViewController.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        remindersViewController.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "list.bullet"), tag: 2)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        
        let homeNav = UINavigationController(rootViewController: homeViewController)
        let createNav = UINavigationController(rootViewController: createViewController)
        let remindersNav = UINavigationController(rootViewController: remindersViewController)
        let profileNav = UINavigationController(rootViewController: profileViewController)
        
        
        homeNav.hidesBarsOnSwipe = true
        
        viewControllers = [homeNav, createNav, remindersNav, profileNav]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
    
 
    
}
