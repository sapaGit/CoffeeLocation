//
//  RegistrationModuleBuilder.swift
//  CoffeeLocation
//

import Foundation

final class RegistrationModuleBuilder {

    /// Assembly the main components for the registration screen.
    ///
    /// - Returns: An instance of `RegistrationViewController` configured with its associated presenter and router.
    class func build() -> RegistrationViewController {
        let view = RegistrationViewController()
        let networkManager = NetworkManager.shared
        let networkService = RegistrationService(netwokManager: networkManager)
        let keychainManager = KeychainManager.shared
        let interactor = RegistrationInteractor(networkService: networkService,keychainManager: keychainManager)
        let router = RegistrationRouter(view: view)
        let presenter = RegistrationPresenter(view: view, interactor: interactor, router: router)


        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}
