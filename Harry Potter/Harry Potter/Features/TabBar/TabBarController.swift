//
//  TabBarController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 10/01/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    private func setupTabBar() {
//        let firstItem = HomeViewController()
//        let secondItem = FavoritesViewController()
        
        setViewControllers([], animated: false)
        tabBar.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        tabBar.barTintColor = .gray
        tabBar.tintColor = .white
        tabBar.isTranslucent = false

        guard let items = tabBar.items else {return}

//        items[0].title = "Home"
//        items[0].image = UIImage(systemName: "bolt")
    }
}
