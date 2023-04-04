//
//  MovieSearchLoginViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 01.04.2023.
//

import UIKit

// MARK: - MovieSearchLoginViewController
class MovieSearchLoginViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 90)
    private let formStackView = MovieSearchStackView(axis: .vertical, spacing: 5)
    private let emailTextField = MovieSearchTextField(placeholderString: "Email", isSecureText: false)
    private let passwordTextField = MovieSearchTextField(placeholderString: "Password", isSecureText: true)
    private let loginButton = MovieSearchButton(backgroundColor: .systemGreen, title: "Login")
    private let createAccountButton = MovieSearchButton(backgroundColor: .systemGreen, title: "Don't have an account? Sign up")
    private let warningMessageLabel = MovieSearchPlainLabel(textAlignment: .center, fontSize: 15)
    
    // MARK: - Private Properties
    private let screenTitleLabelText: String = "Welcome back!"
    private let space: String = " "
    private let alertTitle: String = "Something went wrong"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
        setupLoginButton()
        setupCreateAccountButton()
        setupKeyboardLayout()
        setupTextFieldDelegates()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        titleLabel.text = screenTitleLabelText
    }
    
    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(loginButton)
        formStackView.addArrangedSubview(createAccountButton)
        formStackView.addArrangedSubview(warningMessageLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.heightAnchor.constraint(equalToConstant: 120),
            
            formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            formStackView.widthAnchor.constraint(equalToConstant: 300),
            formStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupCreateAccountButton() {
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    private func setupTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        if email.isEmpty || password.isEmpty ||
            email.contains(space) || password.contains(space) {
            warningMessageLabel.textColor = .systemRed
            warningMessageLabel.text = WarningMessage.fillAllFields
            return
        }
        if email.isValidEmail() {
            if let _ = PersistenceManager.checkEmailForExistence(userKey: email) {
                PersistenceManager.retrieveUser(userKey: email) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let user):
                        guard let userInfo = user.userInfo else { return }
                        if userInfo.password == password {
                            self.move(to: SearchTabBarController(userKey: email))
                        } else {
                            self.warningMessageLabel.textColor = .systemRed
                            self.warningMessageLabel.text = WarningMessage.incorrectPassword
                            return
                        }
                    case .failure(let error):
                        self.presentAlert(withTitle: self.alertTitle, andMessage: error.rawValue)
                        return
                    }
                }
            } else {
                warningMessageLabel.textColor = .systemRed
                warningMessageLabel.text = WarningMessage.accountHasNotBeenCreated
                return
            }
        } else {
            warningMessageLabel.textColor = .systemRed
            warningMessageLabel.text = WarningMessage.invalidEmail
            return
        }
    }
    
    @objc func createAccountButtonTapped() {
        move(to: MovieSearchSignUpViewContoller())
    }
}

// MARK: - UITextFieldDelegate
extension MovieSearchLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
