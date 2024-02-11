//
//  OrderRouter.swift
//  CoffeeLocation
//

import Foundation

protocol OrderRouterProtocol {
    /// Navigate to the Login screen.
    func routToLogin()
}

final class OrderRouter {

    // MARK: - Dependencies

    private weak var view: OrderViewProtocol?

    private var navigationManager: NavigationProtocol

    // MARK: - init

    init(view: OrderViewProtocol, navigarionManager: NavigationProtocol) {
        self.view = view
        self.navigationManager = navigarionManager
    }
}

// MARK: - OrderRouterProtocol

extension OrderRouter: OrderRouterProtocol {
    func routToLogin() {
        navigationManager.navigate(.login)
    }
}

