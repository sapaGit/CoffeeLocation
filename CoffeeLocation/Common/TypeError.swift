//
//  TypeError.swift
//  CoffeeLocation
//

import Foundation

enum TypeError: String, Error {
    case notConnectedToInternet = "No Internet connection"
    case timeLimitExceeded = "Request time limit exceeded"
    case invalidURL = "Некорректный URL"
    case login = "Пара логин/пароль не зарегистрированы. Повторите попытку или зарегистрируйтесь"
    case register = "Невозвожно зарегистрировать данный e-mail"
    case location = "Ошибка при получении локации"
    case fetch = "Ошибка при загрузке данных"
}
