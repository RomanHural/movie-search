//
//  WarningMessages.swift
//  MovieSearch
//
//  Created by Roman Hural on 02.04.2023.
//

import Foundation

enum WarningMessage {
    static let fillAllFields = "Please, fill all fields without spaces"
    static let accountAlreadyCreated = "Cannot create an account. The account with this email has been already created"
    static let accountHasNotBeenCreated = "Account with this email hasn't been created. Please, create an account"
    static let invalidEmail = "Invalid email. Email should be like this: example@example.com"
    static let incorrectPassword = "Incorrect password"
}
