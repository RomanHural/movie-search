//
//  MovieSearchSignUpViewContoller.swift
//  MovieSearch
//
//  Created by Roman Hural on 01.04.2023.
//

import UIKit

// MARK: - MovieSearchSignUpViewContoller
class MovieSearchSignUpViewContoller: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 90)
    private let imageStackView = MovieSearchStackView(axis: .horizontal, spacing: 5)
    private let profilePhotoImageView = MovieSearchProfileImageView(placeholder: "photo.circle", backgroundColor: .systemBackground, borderWidth: .zero, tintColor: .systemBlue)
    private let pickerPhotoImageView = MovieSearchProfileImageView(placeholder: "plus.circle", backgroundColor: .clear, borderWidth: .zero, tintColor: .systemBlue)
    private let formStackView = MovieSearchStackView(axis: .vertical, spacing: 5)
    private let nicknameTextField = MovieSearchTextField(placeholderString: "Nickname", isSecureText: false)
    private let emailTextField = MovieSearchTextField(placeholderString: "Email", isSecureText: false)
    private let passwordTextField = MovieSearchTextField(placeholderString: "Password", isSecureText: true)
    private let signUpButton = MovieSearchButton(backgroundColor: .systemBlue, title: "Sign up")
    private let loginToAccountButton = MovieSearchButton(backgroundColor: .systemBlue, title: "Already have an account? Login")
    private let warningMessageLabel = MovieSearchPlainLabel(textAlignment: .center, fontSize: 15)
    
    // MARK: - Private properties
    private let viewContollerTitle: String = "Create an Account"
    private let space: String = " "
    private let empty: String = ""
    //private let passImageName: String = "selectedImage.png"
    private var selectedImageString: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutUI()
        setupPickerTapGesture()
        signUpButtonSetup()
        setupKeyboardLayout()
        loginToAccountButtonSetup()
        setupTextFieldDelegates()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        titleLabel.text = viewContollerTitle
    }
    
    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(imageStackView)
        view.addSubview(profilePhotoImageView)
        view.addSubview(pickerPhotoImageView)
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(nicknameTextField)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(signUpButton)
        formStackView.addArrangedSubview(loginToAccountButton)
        formStackView.addArrangedSubview(warningMessageLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.heightAnchor.constraint(equalToConstant: 120),
            
            profilePhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            pickerPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 55),
            pickerPhotoImageView.centerYAnchor.constraint(equalTo: profilePhotoImageView.centerYAnchor, constant: 30),
            pickerPhotoImageView.widthAnchor.constraint(equalToConstant: 50),
            pickerPhotoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formStackView.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 10),
            formStackView.widthAnchor.constraint(equalToConstant: 300),
            formStackView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func signUpButtonSetup() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func loginToAccountButtonSetup() {
        loginToAccountButton.addTarget(self, action: #selector(loginToAccountButtonTapped), for: .touchUpInside)
    }
    
    private func setupPickerTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickerTapped))
        pickerPhotoImageView.isUserInteractionEnabled = true
        pickerPhotoImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTextFieldDelegates() {
        nicknameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions
    @objc func pickerTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        guard let nickname = nicknameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        if nickname.isEmpty || email.isEmpty || password.isEmpty ||
            nickname.contains(space) || email.contains(space) || password.contains(space) {
            warningMessageLabel.textColor = .systemRed
            warningMessageLabel.text = WarningMessage.fillAllFields
            return
        }
        if email.isValidEmail() {
            if let _ = PersistenceManager.checkEmailForExistence(userKey: email) {
                warningMessageLabel.textColor = .systemRed
                warningMessageLabel.text = WarningMessage.accountAlreadyCreated
                return
            } else {
                let newAccount = User(userInfo: UserInfo(password: password,
                                                         profilePhoto: selectedImageString ?? empty,
                                                         nickname: nickname),
                                      movies: [])
                PersistenceManager.saveUser(user: newAccount, userKey: email)
                move(to: SearchTabBarController(userKey: email))
            }
        } else {
            warningMessageLabel.textColor = .systemRed
            warningMessageLabel.text = WarningMessage.invalidEmail
            return
        }
    }
    
    @objc func loginToAccountButtonTapped() {
        move(to: MovieSearchLoginViewController())
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MovieSearchSignUpViewContoller: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePhotoImageView.image = info[.originalImage] as? UIImage
        selectedImageString = PhotoFileManager.getImagePath(image: info[.originalImage] as? UIImage)
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension MovieSearchSignUpViewContoller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - UINavigationControllerDelegate
extension MovieSearchSignUpViewContoller: UINavigationControllerDelegate {}
