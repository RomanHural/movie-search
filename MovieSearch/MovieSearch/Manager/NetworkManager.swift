//
//  NetworkManager.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let basicURL = "https://itunes.apple.com"
    
    func getMovies(for search: String, completed: @escaping (Result<MoviesList, MovieSearchError>) -> (Void)) {
        let endPoint = basicURL + "/search?media=movie&term=\(search)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.noMovieFound))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesList = try decoder.decode(MoviesList.self, from: data)
                completed(.success(moviesList))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(nil)
            return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            completed(image)
        }
        task.resume()
    }
}
