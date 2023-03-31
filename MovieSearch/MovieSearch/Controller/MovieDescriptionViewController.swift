//
//  MovieDescriptionViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - MovieDescriptionViewController
class MovieDescriptionViewController: UIViewController {
    
    // MARK: - UI Elements
    let movieTitleLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 40)
    let coverImageView = MovieSearchImageView(frame: .zero)
    let genreMovieLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 14)
    let releasedMovieLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 14)
    let aboutTheMovieLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 20)
    let descriptionMovieLabel = MovieSearchBodyLabel(textAlignment: .left, fontSize: 14)
    let addToFavouritesButton = MovieSearchAddButton(backgroundColor: .systemGreen, title: "Add to Favourites")
    var movie: MovieInfo!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupUI()
        movieSelected(for: movie)
        layoutUI()
        setupNavigationItemLeftBarButton()
        setupAddToFavouritesButton()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func layoutUI() {
        view.addSubview(movieTitleLabel)
        view.addSubview(coverImageView)
        view.addSubview(genreMovieLabel)
        view.addSubview(releasedMovieLabel)
        view.addSubview(aboutTheMovieLabel)
        view.addSubview(descriptionMovieLabel)
        view.addSubview(addToFavouritesButton)
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            coverImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            coverImageView.heightAnchor.constraint(equalToConstant: 150),
            coverImageView.widthAnchor.constraint(equalToConstant: 100),
            
            genreMovieLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor, constant: -5),
            genreMovieLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 10),
            genreMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            genreMovieLabel.heightAnchor.constraint(equalToConstant: 20),
            
            releasedMovieLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor, constant: 15),
            releasedMovieLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 10),
            releasedMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            releasedMovieLabel.heightAnchor.constraint(equalToConstant: 20),
            
            aboutTheMovieLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 20),
            aboutTheMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            aboutTheMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            aboutTheMovieLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionMovieLabel.topAnchor.constraint(equalTo: aboutTheMovieLabel.bottomAnchor, constant: 2),
            descriptionMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addToFavouritesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addToFavouritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToFavouritesButton.widthAnchor.constraint(equalToConstant: 200),
            addToFavouritesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigationItemLeftBarButton() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private func setupAddToFavouritesButton() {
        addToFavouritesButton.addTarget(self, action: #selector(addToFavourites), for: .touchUpInside)
    }
    
    // MARK: - Public Functions
    private func movieSelected(for movie: MovieInfo) {
        movieTitleLabel.text = movie.trackName
        genreMovieLabel.text = "Genre: " + movie.primaryGenreName
        releasedMovieLabel.text = "Release date: " + movie.releaseDate.convertToDisplayFormat()
        aboutTheMovieLabel.text = "About The Movie"
        descriptionMovieLabel.text = movie.longDescription
        DispatchQueue.main.async { self.coverImageView.downloadCoverImage(from: movie.artworkUrl100) }
    }
    
    // MARK: - Actions
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func addToFavourites() {
        print("work")
    }
}
