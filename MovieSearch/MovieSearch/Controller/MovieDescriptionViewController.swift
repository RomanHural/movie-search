//
//  MovieDescriptionViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 30.03.2023.
//

import UIKit

// MARK: - ButtonSettingsDelegate
protocol ButtonSettingsDelegate: AnyObject {
    func getButtonColor() -> UIColor
    func getButtonTitle() -> String
}

// MARK: - MovieDescriptionViewController
class MovieDescriptionViewController: UIViewController {
    
    // MARK: - UI Elements
    private let movieTitleLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 40)
    private let coverImageView = MovieSearchImageView(frame: .zero)
    private let genreMovieLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 14)
    private let releasedMovieLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 14)
    private let aboutTheMovieLabel = MovieSearchTitleLabel(textAlignment: .left, fontSize: 20)
    private let descriptionMovieLabel = MovieSearchBodyLabel(textAlignment: .left, fontSize: 14)
    private let addShareButton = MovieSearchButton(frame: .zero)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - Private Properties
    private let userKey: String?
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let movie: MovieInfo?
    private let emptyString: String = ""
    private let genreText: String = "Genre: "
    private let releaseText: String = "Release date: "
    private let aboutMovieText: String = "About The Movie"
    private let alertTitle: String = "Already in Favourites"
    
    // MARK: - Public Property
    weak var buttonSettingsDelegate: ButtonSettingsDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupUI()
        configureScrollView()
        layoutUI()
        setupNavigationItemRightBarButton()
        setupAddShareToButton()
        setupButton()
        movieSelected(for: movie)
    }
    
    // MARK: - Init
    init(userKey: String, currentMovie: MovieInfo) {
        self.movie = currentMovie
        self.userKey = userKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
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
        view.addSubview(addShareButton)
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            coverImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coverImageView.heightAnchor.constraint(equalToConstant: 150),
            coverImageView.widthAnchor.constraint(equalToConstant: 100),
            
            genreMovieLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor, constant: -5),
            genreMovieLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 10),
            genreMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            genreMovieLabel.heightAnchor.constraint(equalToConstant: 20),
            
            releasedMovieLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor, constant: 15),
            releasedMovieLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 10),
            releasedMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            releasedMovieLabel.heightAnchor.constraint(equalToConstant: 20),
            
            aboutTheMovieLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 20),
            aboutTheMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            aboutTheMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            aboutTheMovieLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionMovieLabel.topAnchor.constraint(equalTo: aboutTheMovieLabel.bottomAnchor, constant: 2),
            descriptionMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            addShareButton.topAnchor.constraint(equalTo: descriptionMovieLabel.bottomAnchor, constant: 40),
            addShareButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addShareButton.widthAnchor.constraint(equalToConstant: 200),
            addShareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigationItemRightBarButton() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func setupButton() {
        addShareButton.set(color: buttonSettingsDelegate?.getButtonColor() ?? .darkGray,
                           title: buttonSettingsDelegate?.getButtonTitle() ?? emptyString)
    }
    
    private func setupAddShareToButton() {
        addShareButton.addTarget(self, action: #selector(addShareButtonTapped), for: .touchUpInside)
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 750)
        ])
    }
    
    private func movieSelected(for movie: MovieInfo?) {
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.trackName
        genreMovieLabel.text = genreText + movie.primaryGenreName
        releasedMovieLabel.text = releaseText + movie.releaseDate.convertToDisplayFormat()
        aboutTheMovieLabel.text = aboutMovieText
        descriptionMovieLabel.text = movie.longDescription
        coverImageView.downloadCoverImage(from: movie.artworkUrl100)
    }
    
    // MARK: - Actions
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func addShareButtonTapped() {
        guard let movie = movie else { return }
        if addShareButton.configuration?.baseBackgroundColor == UIColor.systemGray2 {
            let activityViewController = UIActivityViewController(activityItems: [movie.trackViewUrl], applicationActivities: nil)
            present(activityViewController, animated: true)
        }
        if addShareButton.configuration?.baseBackgroundColor == .systemGreen {
            PersistenceManager.updateWith(userKey: userKey ?? emptyString, favorite: movie, actionType: .add) { [weak self] error in
                guard let self = self,
                      let error = error else { return }
                self.presentAlert(withTitle: self.alertTitle, andMessage: error.rawValue)
            }
        }
    }
}
