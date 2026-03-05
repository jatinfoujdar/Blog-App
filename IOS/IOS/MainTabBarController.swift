//
//  MainTabBarController.swift
//  IOS
//
//  Created by jatin foujdar on 15/02/26.
//

import UIKit

class MainTabBarController : UITabBarController{
    
    let actionBar = ActionBottomBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupTabBar()
        setupActionBar()
    }
    
    private func SetupTabBar(){
        
        let profileViewController = ProfileViewController()
        let homeViewController = HomeViewController()
        let createViewController  = CreatePostViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        createViewController.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
      
        
        
      
      let homeNav = UINavigationController(rootViewController: homeViewController)
      let createNav = UINavigationController(rootViewController: createViewController)
      let profileNav = UINavigationController(rootViewController: profileViewController)
      
        
        homeNav.hidesBarsOnSwipe = true
        
        viewControllers = [homeNav, createNav, profileNav]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = viewControllers?.firstIndex(of: viewController),
              let tabBarButton = tabBar.subviews[index + 1] as? UIControl else { return }
    }
    
    func setupActionBar() {

        view.addSubview(actionBar)

        actionBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            actionBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            actionBar.heightAnchor.constraint(equalToConstant: 60)
        ])

        actionBar.isHidden = true
    }
}
