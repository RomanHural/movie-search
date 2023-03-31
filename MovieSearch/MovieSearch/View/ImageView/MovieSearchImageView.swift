//
//  CoverImageView.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - MovieSearchImageView
class MovieSearchImageView: UIImageView {
    
    // MARK: - Private Property
    private let placeholderImage = UIImage(systemName: "person.circle.fill")
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        
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
