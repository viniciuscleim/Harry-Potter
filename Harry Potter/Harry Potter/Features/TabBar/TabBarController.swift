//
//  TabBarController.swift
//  Harry Potter
//
//  Created by Vinicius Cleim on 10/01/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    var isNewUser: Bool? {
            didSet {
                if let vc1 = self.viewControllers?[2] as? ProfileViewController {
                    vc1.viewModel.isNewUser = isNewUser ?? false
                }
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    private func setupTabBar() {
        let firstItem = HomeViewController()
        let secondItem = FavoritesViewController()
        let thirdItem = ProfileViewController()
        
        setViewControllers([firstItem, secondItem, thirdItem], animated: false)
        tabBar.backgroundColor = UIColor(red: 225/255, green: 198/255, blue: 168/255, alpha: 1.0)
        tabBar.tintColor = .white
        tabBar.isTranslucent = false

        guard let items = tabBar.items else {return}

        items[0].title = "Home"
        items[0].image = UIImage(systemName: "bolt.fill")
        
        items[1].title = "Favorites"
        items[1].image = UIImage(systemName: "heart.fill")
        
        items[2].title = "Profile"
        items[2].image = UIImage(systemName: "person.fill")
    }
}
