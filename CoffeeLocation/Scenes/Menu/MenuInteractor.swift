//
//  MenuInteractor.swift
//  CoffeeLocation
//

import Foundation
import CoreLocation

protocol MenuInteractorProtocol {
    func fetchMenu(id: Int)
    func isOrderIsEmpty() -> Bool
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
    func isOrderIsEmpty() -> Bool {
        if let filterredOrder = presenter?.orderArray.filter({ $0.amount != 0 }) {
            return filterredOrder.isEmpty
        }
        return false
    }

    func fetchMenu(id: Int) {
        guard let token = KeychainManager.shared.accessToken else {
            presenter?.sessionExpired()
            return
        }
        networkService.fetchMenu(id: id,token: token) { [weak self] result in
            switch result {
            case .success(let models):
                self?.presenter?.menuArray = models
                self?.presenter?.didEndFetchMenu()
            case .error:
                self?.presenter?.sessionExpired()
            }
        }
    }
}
