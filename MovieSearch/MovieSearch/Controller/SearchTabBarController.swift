//
//  SearchTabBarController.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import UIKit

// MARK: - SearchTabBarController
class SearchTabBarController: UITabBarController {
    
    // MARK: - Private Properties
    private let mainTabBarItemTitle = "Main"
    private let favouriteTabBarItemTitle = "Favourites"
    private let profileTabBarItemTitle = "Profile"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        viewControllers = [
            createMainNavigationController(),
            createFavouriteNavigationController(),
            createProfileNavigationController()
        ]
    }
    
    // MARK: - Private Methods
   private func createMainNavigationController() -> UINavigationController {
        let mainViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(title: mainTabBarItemTitle,
                                                     image: SFSymbols.magnifyingGlass,
                                                     tag: ViewContollerTag.main.rawValue)
        return UINavigationController(rootViewController: mainViewController)
    }
    
   private func createFavouriteNavigationController() -> UINavigationController {
        let favouriteViewController = FavouritesViewController()
        favouriteViewController.tabBarItem = UITabBarItem(title: favouriteTabBarItemTitle,
                                                          image: SFSymbols.heart,
                                                          tag: ViewContollerTag.favourite.rawValue)
        return UINavigationController(rootViewController: favouriteViewController)
    }
    
    private func createProfileNavigationController() -> UINavigationController {
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: profileTabBarItemTitle,
                                                        image: SFSymbols.person,
                                                        tag: ViewContollerTag.person.rawValue)
        return UINavigationController(rootViewController: profileViewController)
    }
}
