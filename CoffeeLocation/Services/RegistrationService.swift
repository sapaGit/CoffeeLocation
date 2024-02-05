//
//  RegistrationService.swift
//  CoffeeLocation
//


import Foundation

protocol RegistrationServiceProtocol {
    /// Register a user using the provided credentials.
    func register(login: String, password: String, completion: @escaping (AFResult<RegistrationModel>) -> Void)
}

final class RegistrationService {

    // MARK: - Dependencies

    private let netwokManager: NetworkManagerProtocol

    // MARK: - init

    init(netwokManager: NetworkManagerProtocol) {
        self.netwokManager = netwokManager
    }
}

// MARK: - RegistrationServiceProtocol

extension RegistrationService: RegistrationServiceProtocol {
    /// Regiser user using the provided credentials.
    func register(login: String, password: String, completion: @escaping (AFResult<RegistrationModel>) -> Void) {
        
        let parameters = RegistrationEncodable(login: login, password: password).toJSON()
        let request: RequestProtocol = RegistrationRequest(params: parameters)

        netwokManager.makeRequest(request: request, error: .register, completion: completion)
    }
}
