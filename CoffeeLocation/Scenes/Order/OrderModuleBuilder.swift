//
//  OrderModuleBuilder.swift
//  CoffeeLocation
//

import Foundation

final class OrderModuleBuilder {

    /// Assembly the main components for the Order screen.
    ///
    /// - Returns: An instance of `OrderViewController` configured with its associated presenter and router.
    class func build(order: [Order]) -> OrderViewController {
        let view = OrderViewController()
        let navigationManager = NavigationManager.shared
        let interactor = OrderInteractor()
        let router = OrderRouter(view: view, navigarionManager: navigationManager)
        let presenter = OrderPresenter(
            view: view,
            interactor: interactor,
            router: router,
            order: order
        )


        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}
