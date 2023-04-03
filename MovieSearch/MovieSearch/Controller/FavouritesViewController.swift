//
//  FavouritesViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import UIKit

// MARK: - FavouritesViewController
class FavouritesViewController: UIViewController {
    
    // MARK: - UI Element
    private let tableView = UITableView()
    
    // MARK: - Private Properties
    private let favouritesControllerTitle = "Favourites"
    private let rowHeight: CGFloat = 80
    private var favouriteMovies: [MovieInfo] = []
    private let userKey: String?
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let emptyString: String = ""
    private let alertTitle: String = "Something went wrong"
    private let shareButtonTitle: String = "Share a link"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavouriteMovies()
    }
    
    // MARK: - Init
    init(userKey: String) {
        self.userKey = userKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(fatalErrorMessage)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        title = favouritesControllerTitle
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = rowHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseID)
    }
    
    private func getFavouriteMovies() {
        PersistenceManager.retrieveUser(userKey: userKey ?? emptyString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.favouriteMovies = user.movies
                self.tableView.reloadData()
            case .failure(let error):
                self.presentAlert(withTitle: self.alertTitle, andMessage: error.rawValue)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseID, for: indexPath) as! SearchTableViewCell
        let movie = favouriteMovies[indexPath.row]
        cell.configure(movieName: movie.trackName, releaseDate: movie.releaseDate, genre: movie.primaryGenreName)
        cell.setImage(movie: movie)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = MovieDescriptionViewController(userKey: userKey ?? emptyString,
                                                           currentMovie: favouriteMovies[indexPath.row])
        destinationVC.buttonSettingsDelegate = self
        tableView.deselectRow(at: indexPath, animated: true)
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(userKey: userKey ?? emptyString, favorite: favouriteMovies[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let _ = error else {
                self.favouriteMovies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
        }
    }
}

// MARK: - ButtonSettingsDelegate
extension FavouritesViewController: ButtonSettingsDelegate {
    func getButtonColor() -> UIColor { .systemGray2 }
    func getButtonTitle() -> String { shareButtonTitle }
}
