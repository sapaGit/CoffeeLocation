//
//  LoginModel.swift
//  CoffeeLocation
//

import Foundation
import Alamofire

// MARK: - LoginEncodable

struct LoginEncodable: Encodable {
    let login: String
    let password: String
}

// MARK: - LoginRequest

struct LoginRequest: RequestProtocol {
    let url = "auth/login"
    let method: Alamofire.HTTPMethod = .post
    var params: [String: Any]?
}

// MARK: - LoginResponse

struct LoginModel: Decodable {
    let token: String
    let tokenLifetime: Int
}
