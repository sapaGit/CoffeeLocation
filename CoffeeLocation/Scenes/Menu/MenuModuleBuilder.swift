//
//  MenuModuleBuilder.swift
//  CoffeeLocation
//

import Foundation

final class MenuModuleBuilder {

    /// Assembly the main components for the Restaurants screen.
    ///
    /// - Returns: An instance of `RestaurantsViewController` configured with its associated presenter and router.
    class func build(restaurantId: Int) -> MenuViewController {
        let view = MenuViewController()
        let networkManager = NetworkManager.shared
        let networkService = MenuService(netwokManager: networkManager)
        let keychainManager = KeychainManager.shared
        let navigationManager = NavigationManager.shared
        let interactor = MenuInteractor(
            networkService: networkService,
            keychainManager: keychainManager)
        let router = MenuRouter(navigationManager: navigationManager)
        let presenter = MenuPresenter(
            view: view,
            interactor: interactor,
            router: router,
            restaurantId: restaurantId)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}