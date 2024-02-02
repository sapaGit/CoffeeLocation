//
//  LoginRouter.swift
//  CoffeeLocation
//


import Foundation

protocol LoginRouterProtocol {
    /// Navigate to the authentication screen.
    func routToRestaurants()
}

final class LoginRouter {

    // MARK: - Dependencies

    private var navigationManager: NavigationProtocol

    // MARK: - init

    init(navigationManager: NavigationProtocol) {
        self.navigationManager = navigationManager
    }

}

// MARK: - LoginRouterProtocol

extension LoginRouter: LoginRouterProtocol {
    
    func routToRestaurants() {
        navigationManager.navigate(.restaurants)
    }

}
