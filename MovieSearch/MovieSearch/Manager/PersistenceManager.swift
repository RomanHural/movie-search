//
//  PersistanceManager.swift
//  MovieSearch
//
//  Created by Roman Hural on 31.03.2023.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    private static let defaults = UserDefaults.standard
    
    static func updateWith(userKey: String, favorite: MovieInfo, actionType: PersistenceActionType, completed: @escaping (MovieSearchError?) -> Void) {
        retrieveUser(userKey: userKey) { result in
            switch result {
            case .success(var user):
                switch actionType {
                case .add:
                    guard !user.movies.contains(where: { $0 == favorite }) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    user.movies.append(favorite)
                case .remove:
                    user.movies.removeAll(where: { $0 == favorite })
                }
                completed(saveUser(user: user, userKey: userKey))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveUser(userKey: String, completed: @escaping (Result<User, MovieSearchError>) -> Void ) {
        guard let userData = defaults.object(forKey: userKey) as? Data else { completed(.success(User(userInfo: nil, movies: [])))
            return
        }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            completed(.success(user))
        } catch {
            completed(.failure(.unableToComplete))
        }
    }
    
    static func checkEmailForExistence(userKey: String) -> Any? {
        return defaults.object(forKey: userKey)
    }
    
    static func saveUser(user: User, userKey: String) -> MovieSearchError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(user)
            defaults.set(encodedFavorites, forKey: userKey)
            return nil
        } catch {
            return .unableToComplete
        }
    }
    
    static func deleteUser(userKey: String) {
        defaults.removeObject(forKey: userKey)
    }
}
