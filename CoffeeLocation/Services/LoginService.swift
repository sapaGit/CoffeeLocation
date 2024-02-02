//
//  LoginService.swift
//  CoffeeLocation
//


import Foundation

protocol LoginServiceProtocol {
    /// Logs in a user using the provided credentials.
    func login(login: String, password: String, completion: @escaping (AFResult<LoginModel>) -> Void)
}

final class LoginService {

    // MARK: - Dependencies

    private let netwokManager: NetworkManagerProtocol

    // MARK: - init

    init(netwokManager: NetworkManagerProtocol) {
        self.netwokManager = netwokManager
    }
}

// MARK: - AuthServiceProtocol

extension LoginService: LoginServiceProtocol {
    /// Logs in a user using the provided credentials.
    func login(login: String, password: String, completion: @escaping (AFResult<LoginModel>) -> Void) {

        let parameters = LoginEncodable(login: login, password: password).toJSON()
        let request: RequestProtocol = LoginRequest(params: parameters)

        netwokManager.makeRequest(request: request, error: .login, completion: completion)
    }
}
