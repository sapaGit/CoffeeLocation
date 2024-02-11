//
//  LoginModuleBuilder.swift
//  CoffeeLocation
//


import Foundation

final class LoginModuleBuilder {

    /// Assembly the main components for the login screen.
    ///
    /// - Returns: An instance of `LoginViewController` configured with its associated presenter and router.
    class func build() -> LoginViewController {
        let view = LoginViewController()
        let networkManager = NetworkManager.shared
        let networkService = LoginService(netwokManager: networkManager)
        let keychainManager = KeychainManager.shared
        let navigationManager = NavigationManager.shared
        let interactor = LoginInteractor(
            networkService: networkService,
            keychainManager: keychainManager
        )
        let router = LoginRouter(navigationManager: navigationManager)
        let presenter = LoginPresenter(
            view: view,
            interactor: interactor,
            router: router
        )

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}
