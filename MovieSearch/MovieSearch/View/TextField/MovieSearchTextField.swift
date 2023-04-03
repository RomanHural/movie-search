//
//  MovieSearchTextField.swift
//  MovieSearch
//
//  Created by Roman Hural on 01.04.2023.
//

import UIKit

// MARK: - MovieSearchTextField
class MovieSearchTextField: UITextField {
    
    // MARK: - Private Properties
    private let cornerRadius: CGFloat = 8
    private let borderWidth: CGFloat = 2
    private let minimumFontSizeValue: CGFloat = 12
    private let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    convenience init(placeholderString: String, isSecureText: Bool) {
        self.init(frame: .zero)
        self.placeholder = placeholderString
        self.isSecureTextEntry = isSecureText
    }
    
    // MARK: - Private Method
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.black.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = minimumFontSizeValue
        
        clearButtonMode = .whileEditing
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        paddingView.backgroundColor = .clear
        leftView = paddingView
        leftViewMode = .always
    }
}
