//
//  MovieSearchBodyLabel.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//
import UIKit

// MARK: - MovieSearchBodyLabel
class MovieSearchBodyLabel: UILabel {
    
    // MARK: - Private Property
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    // MARK: - Private Method
    private func configure() {
        sizeToFit()
        numberOfLines = .zero
        textColor = .secondaryLabel
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
