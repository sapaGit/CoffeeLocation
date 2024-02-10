//
//  MenuRouter.swift
//  CoffeeLocation
//

import Foundation

protocol MenuRouterProtocol {
    /// Navigate to the authentication screen.
    func routToPayment()
}

final class MenuRouter {

    // MARK: - Dependencies

    private var navigationManager: NavigationProtocol

    // MARK: - init

    init(navigationManager: NavigationProtocol) {
        self.navigationManager = navigationManager
    }

}

// MARK: - MenuRouterProtocol

extension MenuRouter: MenuRouterProtocol {

    func routToPayment() {
    }
}
