//
//  SearchTableViewCell.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - SearchTableViewCell
class SearchTableViewCell: UITableViewCell {
    static let reuseID = "SearchCell"
    
    // MARK: - UI Elements
    private let coverImageView = MovieSearchImageView(frame: .zero)
    private let movieNameLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 17)
    private let genreLabel = MovieSearchBodyLabel(textAlignment: .left, fontSize: 12)
    private let releaseDateLabel = MovieSearchBodyLabel(textAlignment: .left, fontSize: 12)
    
    // MARK: - Private Properties
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let genreText: String = "Genre: "
    private let releaseText: String = "Release date: "
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    // MARK: - Private Method
    private func setupUI() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(releaseDateLabel)
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            coverImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            coverImageView.heightAnchor.constraint(equalToConstant: 60),
            coverImageView.widthAnchor.constraint(equalToConstant: 60),
            
            movieNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            movieNameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: padding),
            movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            genreLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: -2),
            genreLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            genreLabel.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: -5),
            releaseDateLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Public Methods
    func configure(movieName: String, releaseDate: String, genre: String) {
        movieNameLabel.text = movieName
        genreLabel.text = genreText + genre
        releaseDateLabel.text = releaseText + releaseDate.convertToDisplayFormat()
    }
    
    func setImage(movie: MovieInfo) {
        coverImageView.downloadCoverImage(from: movie.artworkUrl100)
    }
}
