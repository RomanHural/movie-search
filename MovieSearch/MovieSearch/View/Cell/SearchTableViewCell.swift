//
//  SearchTableViewCell.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let reuseID = "SearchCell"
    
    let coverImageView = MovieSearchImageView(frame: .zero)
    let movieNameLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 17)
    let genreLabel = MovieSearchBodyLabel(textAlignment: .left, fontSize: 12)
    let releaseDateLabel = MovieSearchBodyLabel(textAlignment: .left, fontSize: 12)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            
            movieNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
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
    
    func configure(movieName: String, releaseDate: String, genre: String) {
        movieNameLabel.text = movieName
        genreLabel.text = "Genre: \(genre)"
        releaseDateLabel.text = "Released: \(releaseDate.convertToDisplayFormat())"
    }
    
    func setImage(movie: MovieInfo) {
        coverImageView.downloadCoverImage(from: movie.artworkUrl100)
    }
}
