//
//  MenuInteractor.swift
//  CoffeeLocation
//

import Foundation
import CoreLocation

protocol MenuInteractorProtocol {

    func fetchMenu(id: Int)
}

final class MenuInteractor: NSObject {

    // MARK: - Dependencies

    weak var presenter: MenuPresenterProtocol?
    var networkService: MenuServiceProtocol
    var keychainManager: KeychainManager

    init(networkService: MenuServiceProtocol, keychainManager: KeychainManager) {
        self.networkService = networkService
        self.keychainManager = keychainManager
    }
}

// MARK: - RestaurantsInteractorProtocol

extension MenuInteractor: MenuInteractorProtocol {

    func fetchMenu(id: Int) {

        // move token to keychain
        guard let token = KeychainManager.shared.accessToken else {
            presenter?.error(typeError: .login)
            return
        }
        networkService.fetchMenu(id: id,token: token) { [weak self] result in

            switch result {
            case .success(let models):
                self?.presenter?.menuArray = models
                self?.presenter?.didEndFetchMenu()

            case .error:
                self?.presenter?.error(typeError: .fetch)
            }
        }
    }


}
