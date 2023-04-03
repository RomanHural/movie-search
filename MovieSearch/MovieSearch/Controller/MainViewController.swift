//
//  ViewController.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import UIKit

// MARK: - MainViewController
class MainViewController: UIViewController {
    
    // MARK: - UI Element
    private let tableView = UITableView()
    private let searchController = UISearchController()
    
    // MARK: - Private Properties
    private let mainControllerTitle: String = "Main"
    private let searchBarPlaceholder: String = "Search for a movie"
    private let emptyString: String = ""
    private let rowHeight: CGFloat = 80
    private let userKey: String?
    private let fatalErrorMessage: String = "init(coder:) has not been implemented"
    private let addButtonTitle: String = "Add to Favourites"
    private let alertTitle: String = "Something went wrong"
    private let alertMessage: String = "There is no movie with this title. Please, try enter other title"
    private var movies: [MovieInfo] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureSearchController()
        configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.searchBar.resignFirstResponder()
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
        title = mainControllerTitle
    }
    
    private func configureSearchController() {
        searchController.searchBar.placeholder = searchBarPlaceholder
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = rowHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseID)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseID, for: indexPath) as! SearchTableViewCell
        let movie = movies[indexPath.row]
        cell.configure(movieName: movie.trackName, releaseDate: movie.releaseDate, genre: movie.primaryGenreName)
        cell.setImage(movie: movie)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = MovieDescriptionViewController(userKey: userKey ?? emptyString, currentMovie: movies[indexPath.row])
        destinationVC.buttonSettingsDelegate = self
        tableView.deselectRow(at: indexPath, animated: true)
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else { return }
        NetworkManager.shared.getMovies(for: searchQuery) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieList):
                self.movies = movieList.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if !self.movies.isEmpty {
                        self.tableView.scrollToRow(at: IndexPath(row: .zero, section: .zero),
                                                   at: .top,
                                                   animated: true)
                    } else {
                        self.presentAlert(withTitle: self.alertTitle, andMessage: self.alertMessage)
                    }
                }
            case .failure(let error):
                self.movies = []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.presentAlert(withTitle: self.alertTitle, andMessage: error.rawValue)
                }
            }
        }
    }
}

// MARK: - ButtonSettingsDelegate
extension MainViewController: ButtonSettingsDelegate {
    func getButtonColor() -> UIColor { .systemGreen }
    func getButtonTitle() -> String { addButtonTitle }
}
