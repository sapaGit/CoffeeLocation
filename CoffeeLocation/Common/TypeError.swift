//
//  TypeError.swift
//  CoffeeLocation
//

import Foundation

enum TypeError: String, Error {
    case notConnectedToInternet = "No Internet connection"
    case timeLimitExceeded = "Request time limit exceeded"
    case invalidURL = "Incorrect URL"
    case login = "Ошибка авторизации"
    case register = "Ошибка регистрации"
    case logout = "Failed to sign out of account"
    case location = "Ошибка при получении локации"
    case fetch = "Ошибка при загрузке данных"
}
