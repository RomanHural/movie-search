//
//  MovieSearchProfileImageView.swift
//  MovieSearch
//
//  Created by Roman Hural on 31.03.2023.
//

import UIKit

// MARK: - MovieSearchProfileImageView
class MovieSearchProfileImageView: UIImageView {
    
    // MARK: - Private Properties
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let cornerRadius: CGFloat = 50
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    convenience init(placeholder: String, backgroundColor: UIColor, borderWidth: CGFloat, tintColor: UIColor) {
        self.init(frame: .zero)
        self.image = UIImage(systemName: placeholder)
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = borderWidth
        self.tintColor = tintColor
        
    }
    
    // MARK: - Private Method
    private func configure() {
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
