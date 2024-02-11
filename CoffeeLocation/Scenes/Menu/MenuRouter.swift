//
//  MenuRouter.swift
//  CoffeeLocation
//

import Foundation

protocol MenuRouterProtocol {
    func routToPayment(order: [Order])
    func routToLogin()
}

final class MenuRouter {

    // MARK: - Dependencies

    private weak var view: MenuViewProtocol?
    private let navigationManager: NavigationProtocol

    // MARK: - init

    init(view: MenuViewProtocol?, navigationManager: NavigationProtocol) {
        self.view = view
        self.navigationManager = navigationManager
    }
}

// MARK: - MenuRouterProtocol

extension MenuRouter: MenuRouterProtocol {
    func routToLogin() {
        navigationManager.navigate(.login)
    }
    func routToPayment(order: [Order]) {
        view?.pushViewController(
            OrderModuleBuilder.build(order: order),
            animated: true)
    }
}
