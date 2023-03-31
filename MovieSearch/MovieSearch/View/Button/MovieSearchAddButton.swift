//
//  MovieSearchAddButton.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - MovieSearchAddButton
class MovieSearchAddButton: UIButton {
    
    // MARK: - Private Properties
    private let cornerRadius: CGFloat = 10
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: backgroundColor, title: title)
    }
    
    // MARK: - Private Method
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = .tinted()
        configuration?.cornerStyle = .medium
    }
    
    // MARK: - Public Method
    func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
    }
}
