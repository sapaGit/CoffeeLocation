//
//  RegistrationModel.swift
//  CoffeeLocation
//


import Foundation
import Alamofire

// MARK: - RegistrationEncodable

struct RegistrationEncodable: Encodable {
    let login: String
    let password: String
}

// MARK: - RegistrationRequest

struct RegistrationRequest: RequestProtocol {
    let url = "auth/register"
    var params: [String: Any]?
    let method: Alamofire.HTTPMethod = .post
}

// MARK: - RegistrationResponse

struct RegistrationModel: Decodable {
    let token: String
    let tokenLifetime: Int
}
