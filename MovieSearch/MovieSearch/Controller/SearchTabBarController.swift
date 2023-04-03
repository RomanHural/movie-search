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
    private let mainTabBarItemTitle: String = "Main"
    private let favouriteTabBarItemTitle: String = "Favourites"
    private let profileTabBarItemTitle: String = "Profile"
    private let userKey: String?
    private let emptyString: String = ""
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        viewControllers = [
            createMainNavigationController(),
            createFavouriteNavigationController(),
            createProfileNavigationController()
        ]
    }
    
    // MARK: - Init
    init(userKey: String) {
        self.userKey = userKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    // MARK: - Private Methods
    private func createMainNavigationController() -> UINavigationController {
        let mainViewController = MainViewController(userKey: userKey ?? emptyString)
        mainViewController.tabBarItem = UITabBarItem(title: mainTabBarItemTitle,
                                                     image: SFSymbols.magnifyingGlass,
                                                     tag: ViewContollerTag.main.rawValue)
        return UINavigationController(rootViewController: mainViewController)
    }
    
    private func createFavouriteNavigationController() -> UINavigationController {
        let favouriteViewController = FavouritesViewController(userKey: userKey ?? emptyString)
        favouriteViewController.tabBarItem = UITabBarItem(title: favouriteTabBarItemTitle,
                                                          image: SFSymbols.heart,
                                                          tag: ViewContollerTag.favourite.rawValue)
        return UINavigationController(rootViewController: favouriteViewController)
    }
    
    private func createProfileNavigationController() -> UINavigationController {
        let profileViewController = ProfileViewController(userKey: userKey ?? emptyString)
        profileViewController.tabBarItem = UITabBarItem(title: profileTabBarItemTitle,
                                                        image: SFSymbols.person,
                                                        tag: ViewContollerTag.person.rawValue)
        return UINavigationController(rootViewController: profileViewController)
    }
}
