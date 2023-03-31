//
//  MovieSearchTitleLabel.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import Foundation
import UIKit

// MARK: - MovieSearchTitleLabel
class MovieSearchTitleLabel: UILabel {
    
    // MARK: - Private Properties
    private let minimumScaleFactorValue: CGFloat = 0.5
    
    // MARK: = Lifw Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
