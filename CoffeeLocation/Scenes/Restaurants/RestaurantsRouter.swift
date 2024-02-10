//
//  RestaurantsRouter.swift
//  CoffeeLocation
//

import Foundation

protocol RestaurantsRouterProtocol {
    /// Navigate to the Menu screen.
    func routToMenu(restaurantId: Int)
}

final class RestaurantsRouter {

    // MARK: - Dependencies

    private weak var view: RestaurantsViewProtocol?

    // MARK: - init

    init(view: RestaurantsViewProtocol) {
        self.view = view
    }

}

// MARK: - LoginRouterProtocol

extension RestaurantsRouter: RestaurantsRouterProtocol {

    func routToMenu(restaurantId: Int) {
        view?.pushViewController(
            MenuModuleBuilder.build(restaurantId: restaurantId),
            animated: true
        )
    }
}
