//
//  MovieSearchError.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import Foundation

enum MovieSearchError: String, Error {
    case noMovieFound = "There is no movie with this title. Please, try enter other title."
    case unableToComplete = "Unable to complete the request. Please, check your internet connection and try again."
    case invalidResponse = "Invalid response from the server. Please, try again."
    case invalidData = "The data received from a server was invalid. Please, try again."
}
