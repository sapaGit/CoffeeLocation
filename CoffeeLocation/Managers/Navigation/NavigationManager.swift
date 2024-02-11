//
//  NavigationManager.swift
//  CoffeeLocation
//

import UIKit

enum Route {
    case login
    case restaurants
}

protocol NavigationProtocol {
    /// Sets the main window for the app.
    ///
    /// - Parameters:
    ///   - window: The main window to be set for the app.
    ///   - completionHandler: A closure that is called after the window is set.
    func setWindow(_ window: UIWindow?)

    /// Navigates to a specific route
    func navigate(_ route: Route)
}

final class NavigationManager {

    // MARK: - Properties

    static let shared = NavigationManager()
    private var window: UIWindow?

    // MARK: - init

    private init() {}

}

// MARK: - NavigationProtocol

extension NavigationManager: NavigationProtocol {
    /// Sets the main window for the app.
    ///
    /// - Parameters:
    ///   - window: The main window to be set for the app.
    func setWindow(_ window: UIWindow?) {
        self.window = window
        guard KeychainManager.shared.isAuthorized else {
            navigate(.login)
            return
        }
        navigate(.restaurants)
    }

    /// Navigates to the specified route.
    ///
    /// - Parameter route: The route to navigate to.
    ///     - If the route is  `.login`, sets the RegistrartionViewController as the root.
    ///     - If the route is `.restaurants`, sets the RestaurantsViewController as the root.
    func navigate(_ route: Route) {
        switch route {
        case .login:
            setRootController(createAuthModule())
        case .restaurants:
            setRootController(createRestaurantModule())
        }
    }
}

// MARK: - Private methods

private extension NavigationManager {

    func setRootController(_ controller: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }


    func createAuthModule() -> UINavigationController {
        let registrationModule = RegistrationModuleBuilder.build()
        let navigationController = UINavigationController(rootViewController: registrationModule)
        return navigationController
    }

    func createRestaurantModule() -> UINavigationController {
        let restaurantsModule = RestaurantsModuleBuilder.build()
        let navigationController = UINavigationController(rootViewController: restaurantsModule)
        return navigationController
    }
}
