//
//  ProfileViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import UIKit

// MARK: - ProfileViewController
class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    private let profilePhotoImageView = MovieSearchProfileImageView(frame: .zero)
    private let nicknameLabel = MovieSearchTitleLabel(textAlignment: .center, fontSize: 35)
    private let emailLabel = MovieSearchBodyLabel(textAlignment: .center, fontSize: 15)
    private let logoutButton = MovieSearchButton(backgroundColor: .systemRed, title: "Log out")
    private let deleteAccountButton = MovieSearchButton(backgroundColor: .systemRed, title: "Delete account")
    private let labelsStackView = MovieSearchStackView(axis: .vertical, spacing: 2)
    private let buttonsStackView = MovieSearchStackView(axis: .vertical, spacing: 5)
    
    // MARK: - Private Properties
    private let profileControllerTitle = "Profile"
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let emptyString: String = ""
    private let alertTitle: String = "Something went wrong"
    private let userKey: String?
    private var user: User?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
        setupLogoutButton()
        setupDeleteAccountButton()
        fillUserInfo(with: userKey ?? emptyString)
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
    private func fillUserInfo(with key: String) {
        PersistenceManager.retrieveUser(userKey: key) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                DispatchQueue.global().async {
                    let image = self.getImage(for: user.userInfo?.profilePhoto ?? self.emptyString)
                    DispatchQueue.main.async {
                        self.profilePhotoImageView.image = image
                        self.nicknameLabel.text = self.user?.userInfo?.nickname ?? self.emptyString
                        self.emailLabel.text = key
                    }
                }
            case .failure(let error):
                self.presentAlert(withTitle: self.alertTitle, andMessage: error.rawValue)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = profileControllerTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layoutUI() {
        view.addSubview(profilePhotoImageView)
        view.addSubview(labelsStackView)
        view.addSubview(buttonsStackView)
        labelsStackView.addArrangedSubview(nicknameLabel)
        labelsStackView.addArrangedSubview(emailLabel)
        buttonsStackView.addArrangedSubview(logoutButton)
        buttonsStackView.addArrangedSubview(deleteAccountButton)
        
        NSLayoutConstraint.activate([
            profilePhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 150),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 150),
            
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelsStackView.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 10),
            labelsStackView.heightAnchor.constraint(equalToConstant: 100),
            labelsStackView.widthAnchor.constraint(equalToConstant: 300),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 200),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLogoutButton() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    private func setupDeleteAccountButton() {
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
    }
    
    private func getImage(for path: String) -> UIImage? {
        let imageURL = URL(fileURLWithPath: path)
        if let imageData = try? Data(contentsOf: imageURL) {
            return UIImage(data: imageData)
        }
        return SFSymbols.photoCircle
    }
    
    // MARK: - Actions
    @objc func logoutButtonTapped() {
        move(to: MovieSearchLoginViewController())
    }
    
    @objc func deleteAccountButtonTapped() {
        PersistenceManager.deleteUser(userKey: userKey ?? emptyString)
        move(to: MovieSearchSignUpViewContoller())
    }
}
