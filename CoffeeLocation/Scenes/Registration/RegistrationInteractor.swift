//
//  RegistrationInteractor.swift
//  CoffeeLocation
//


import Foundation
import Alamofire

protocol RegistrationInteractorProtocol {

    func register(login: String, password: String)
}

final class RegistrationInteractor {

    // MARK: - Dependencies

    weak var presenter: RegistrationPresenterProtocol?
    var networkService: RegistrationServiceProtocol
    var keychainManager: KeychainManager

    init(networkService: RegistrationServiceProtocol, keychainManager: KeychainManager) {
        self.networkService = networkService
        self.keychainManager = keychainManager
    }
}

// MARK: - RegistrationInteractorProtocol

extension RegistrationInteractor: RegistrationInteractorProtocol {

    func register(login: String, password: String) {
        networkService.register(login: login, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.presenter?.didRegister()
            case .error:
                self?.presenter?.error(typeError: .register)
            }
        }
    }
}

