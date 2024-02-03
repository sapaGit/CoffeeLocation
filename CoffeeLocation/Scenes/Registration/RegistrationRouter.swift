//
//  RegistrationRouter.swift
//  CoffeeLocation
//


import Foundation

protocol RegistrationRouterProtocol {
    /// Navigate to the login screen.
    func routToLogin()
}

final class RegistrationRouter {

    // MARK: - Dependencies

    private weak var view: RegistrationViewProtocol?

    // MARK: - init

    init(view: RegistrationViewProtocol) {
        self.view = view
    }

}

// MARK: - RegistrationRouterProtocol

extension RegistrationRouter: RegistrationRouterProtocol {

    func routToLogin() {
        let loginModule = LoginModuleBuilder.build()
        view?.pushViewController(loginModule, animated: true)
    }

}
