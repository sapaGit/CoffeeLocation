//
//  RestaurantsRouter.swift
//  CoffeeLocation
//

import Foundation

protocol RestaurantsRouterProtocol {
    /// Navigate to the authentication screen.
    func routToRestaurants()
}

final class RestaurantsRouter {

    // MARK: - Dependencies

    private var navigationManager: NavigationProtocol

    // MARK: - init

    init(navigationManager: NavigationProtocol) {
        self.navigationManager = navigationManager
    }

}

// MARK: - LoginRouterProtocol

extension RestaurantsRouter: RestaurantsRouterProtocol {

    func routToRestaurants() {
        navigationManager.navigate(.restaurants)
    }

}
