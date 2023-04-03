//
//  MovieSearchTitleLabel.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - MovieSearchTitleLabel
class MovieSearchTitleLabel: UILabel {
    
    // MARK: - Private Properties
    private let minimumScaleFactorValue: CGFloat = 0.5
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    
    // MARK: = Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
    
    // MARK: - Private Method
    private func configure() {
        numberOfLines = .zero
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = minimumScaleFactorValue
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
