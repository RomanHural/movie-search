//
//  MovieSearchFullNameStackView.swift
//  MovieSearch
//
//  Created by Roman Hural on 31.03.2023.
//

import UIKit

// MARK: - MovieSearchFullNameStackView
class MovieSearchStackView: UIStackView {
    
    // MARK: - Private Property
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(frame: .zero)
        self.axis = axis
        self.alignment = .fill
        self.spacing = spacing
        self.distribution = .fillEqually
    }
    
    // MARK: - Private Method
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
