//
//  RestaurantsModuleBuilder.swift
//  CoffeeLocation
//

import Foundation

final class RestaurantsModuleBuilder {

    /// Assembly the main components for the Restaurants screen.
    ///
    /// - Returns: An instance of `RestaurantsViewController` configured with its associated presenter and router.
    class func build() -> RestaurantsViewController {
        let view = RestaurantsViewController()
        let networkManager = NetworkManager.shared
        let networkService = RestaurantsService(netwokManager: networkManager)
        let keychainManager = KeychainManager.shared
        let navigationManager = NavigationManager.shared
        let interactor = RestaurantsInteractor(
            networkService: networkService,
            keychainManager: keychainManager
        )
        let router = RestaurantsRouter(
            view: view,
            navigarionManager: navigationManager
        )
        let presenter = RestaurantsPresenter(
            view: view,
            interactor: interactor,
            router: router
        )

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}
