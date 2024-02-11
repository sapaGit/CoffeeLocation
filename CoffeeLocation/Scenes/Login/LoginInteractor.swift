//
//  LoginInteractor.swift
//  CoffeeLocation
//


import Foundation

protocol LoginInteractorProtocol {

    func login(login: String, password: String)
}

final class LoginInteractor {

    // MARK: - Dependencies

    weak var presenter: LoginPresenterProtocol?
    var networkService: LoginServiceProtocol
    var keychainManager: KeychainManager

    init(networkService: LoginServiceProtocol, keychainManager: KeychainManager) {
        self.networkService = networkService
        self.keychainManager = keychainManager
    }
}

// MARK: - LoginInteractorProtocol

extension LoginInteractor: LoginInteractorProtocol {
    
    func login(login: String, password: String) {
        networkService.login(login: login, password: password) { [weak self] result in
            switch result {
            case .success(let loginModel):
                self?.keychainManager.setTokens(loginModel)
                self?.presenter?.didLogin()
            case .error:
                self?.presenter?.error(typeError: .login)
            }
        }
    }
}
