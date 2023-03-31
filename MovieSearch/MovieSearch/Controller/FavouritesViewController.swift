//
//  FavouriteViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import UIKit

// MARK: - FavouriteViewController
class FavouritesViewController: UIViewController {
    
    // MARK: - Private Properties
    private let favouritesControllerTitle = "Favourites"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = favouritesControllerTitle
    }
}
