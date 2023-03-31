//
//  ProfileViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import UIKit

// MARK: - ProfileViewController
class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profileControllerTitle = "Profile"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = profileControllerTitle
    }
}
