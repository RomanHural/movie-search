//
//  CoverImageView.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - MovieSearchImageView
class MovieSearchImageView: UIImageView {
    
    // MARK: - Private Properties
    private let placeholderImage = UIImage(systemName: "square.fill")
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let cornerRadius: CGFloat = 10
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    // MARK: - Private Method
    private func configure() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        image = placeholderImage
        tintColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public Method
    func downloadCoverImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
