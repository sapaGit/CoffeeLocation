//
//  RestaurantsInteractor.swift
//  CoffeeLocation
//

import Foundation
import CoreLocation

protocol RestaurantsInteractorProtocol {

    func fetchRestaurants()

    func getDistansesFromRestaurants(restaurants: [RestaurantsModel])
}

final class RestaurantsInteractor: NSObject {

    // MARK: - Dependencies

    weak var presenter: RestaurantsPresenterProtocol?
    var networkService: RestaurantsServiceProtocol
    var keychainManager: KeychainManager

    init(networkService: RestaurantsServiceProtocol, keychainManager: KeychainManager) {
        self.networkService = networkService
        self.keychainManager = keychainManager
    }
}

// MARK: - RestaurantsInteractorProtocol

extension RestaurantsInteractor: RestaurantsInteractorProtocol {

    func fetchRestaurants() {

        // move token to keychain
        guard let token = KeychainManager.shared.accessToken else {
            presenter?.error(typeError: .login)
            return
        }
        networkService.fetchRestaurants(token: token) { [weak self] result in

            switch result {
            case .success(let models):
                self?.presenter?.restaurants = models
                self?.presenter?.didEndFetchRestaurants()

            case .error:
                self?.presenter?.error(typeError: .fetch)
            }
        }
    }

    func getDistansesFromRestaurants(restaurants: [RestaurantsModel]) {
        let locationManager = LocationManager.shared
        locationManager.getUserLocation { [weak self] location in
            guard let location = location else {
                self?.presenter?.error(typeError: .location)
                return
            }
            DispatchQueue.main.async {
                for restaurant in restaurants {
                    guard let latitude = Double(restaurant.point.latitude),
                          let longitude = Double(restaurant.point.longitude) else {
                        return
                    }
                    let distance = location.distance(from: CLLocation(
                        latitude: latitude,
                        longitude: longitude)
                    )
                    self?.presenter?.distances.append(Int(distance))
                }
                self?.presenter?.didEndFetchLocation()
            }
        }
    }
}
