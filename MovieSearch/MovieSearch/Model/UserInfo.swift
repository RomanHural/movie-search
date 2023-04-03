//
//  UserInfo.swift
//  MovieSearch
//
//  Created by Roman Hural on 01.04.2023.
//

import Foundation

struct UserInfo: Codable, Equatable {
    let password: String
    let profilePhoto: String
    let nickname: String
}
