//
//  User.swift
//  MovieSearch
//
//  Created by Roman Hural on 31.03.2023.
//

import Foundation

struct User: Codable, Equatable {
    let userInfo: UserInfo?
    var movies: [MovieInfo]
}
