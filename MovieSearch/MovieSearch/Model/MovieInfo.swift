//
//  MovieInfo.swift
//  MovieSearch
//
//  Created by Roman Hural on 29.03.2023.
//

import Foundation

struct MovieInfo: Codable {
    let artworkUrl100: String
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let longDescription: String
}
