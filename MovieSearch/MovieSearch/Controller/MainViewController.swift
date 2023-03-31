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
    
    // MARK: - Private Properties
    private let mainControllerTitle = "Main"
    private let searchBarPlaceholder = "Search for a movie"
    private let rowHeight: CGFloat = 80
    private var movies: [MovieInfo] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = mainControllerTitle
        configureSearchController()
        configureTableView()
    }
    
    // MARK: - Private Methods
    private func configureSearchController() {
        let searchController = UISearchController()
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
        let destinationVC = MovieDescriptionViewController()
        destinationVC.movie = movies[indexPath.row]
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
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
