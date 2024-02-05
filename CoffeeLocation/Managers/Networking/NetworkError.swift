//
//  NetworkError.swift
//  CoffeeLocation
//

import Foundation

final class NetworkError: NSObject, Error {

    // MARK: - Properties

    var type: TypeError
    var message: String?

    // MARK: - init

    init(_ type: TypeError, message: String? = nil) {
        self.type = type
        self.message = message
    }
}

// TODO: add SwiftGen

enum TypeError: String, Error {
    case notConnectedToInternet = "No Internet connection"
    case timeLimitExceeded = "Request time limit exceeded"
    case invalidURL = "Incorrect URL"
    case login = "Authorisation Error"
    case register = "Registration error"
    case restaurants = "Failed to get restaurants information"
    case logout = "Failed to sign out of account"
}
