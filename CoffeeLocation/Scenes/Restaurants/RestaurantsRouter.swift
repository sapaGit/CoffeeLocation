//
//  RestaurantsRouter.swift
//  CoffeeLocation
//

import Foundation

protocol RestaurantsRouterProtocol {
    /// Navigate to the Menu screen.
    func routToMenu(restaurantId: Int)

    /// Navigate to the Login screen.
    func routToLogin()
}

final class RestaurantsRouter {

    // MARK: - Dependencies

    private weak var view: RestaurantsViewProtocol?

    private let navigationManager: NavigationProtocol

    // MARK: - init

    init(view: RestaurantsViewProtocol, navigarionManager: NavigationProtocol) {
        self.view = view
        self.navigationManager = navigarionManager
    }

}

// MARK: - RestaurantsRouterProtocol

extension RestaurantsRouter: RestaurantsRouterProtocol {
    func routToLogin() {
        navigationManager.navigate(.login)
    }
    
    func routToMenu(restaurantId: Int) {
        view?.pushViewController(
            MenuModuleBuilder.build(restaurantId: restaurantId),
            animated: true
        )
    }
}
