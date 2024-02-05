//
//  RestaurantsInteractor.swift
//  CoffeeLocation
//

import Foundation
import CoreLocation

protocol RestaurantsInteractorProtocol {

    func fetchRestaurants()

    func login(login: String, password: String)

    func getUserLocation()
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
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImNvZmZlZSBiYWNrZW5kIiwiaWQiOjk5MiwiZXhwIjoxNzA3MTM4NTQ1fQ.NPLdNs7YDzpzEKV7H5zHGBFvN_YPPZK2wCy-8ioTmJ8"
        networkService.fetchRestaurants(token: token) { [weak self] result in

            switch result {
            case .success(let models):
                self?.presenter?.restaurants = models
                self?.presenter?.didEndFetchRestaurants()

            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getUserLocation() {
        let locationManager = CLLocationManager()
        DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    // Perform UI-related tasks on the main thread
                    DispatchQueue.main.async {
                        locationManager.delegate = self
                        locationManager.desiredAccuracy = .leastNonzeroMagnitude
                        locationManager.requestWhenInUseAuthorization()
                        // You can also call locationManager.startUpdatingLocation() here if needed
                    }
                } else {
                    // Handle the case where location services are not enabled
                }
            }
    }


    func login(login: String, password: String) {
        networkService.register(login: login, password: password) { [weak self] result in
            switch result {
            case .success(let loginModel):
                print(loginModel.id)
//                self?.keychainManager.setTokens(loginModel)
                self?.presenter?.didLogin()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension RestaurantsInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        print(location)
    }
}
