//
//  RestaurantsService.swift
//  CoffeeLocation
//

import Foundation
import Alamofire

protocol RestaurantsServiceProtocol {

    func fetchRestaurants(token: String, completion: @escaping (AFResult<[RestaurantsModel]>) -> Void)
    /// Register a user using the provided credentials.
    func register(login: String, password: String, completion: @escaping (AFResult<RestaurantsModel>) -> Void)
}

final class RestaurantsService {

    // MARK: - Dependencies

    private let netwokManager: NetworkManagerProtocol

    // MARK: - init

    init(netwokManager: NetworkManagerProtocol) {
        self.netwokManager = netwokManager
    }
}

// MARK: - RegistrationServiceProtocol

extension RestaurantsService: RestaurantsServiceProtocol {

    func fetchRestaurants(token: String, completion: @escaping (AFResult<[RestaurantsModel]>) -> Void) {
        let headers: HTTPHeaders?  = ["Authorization": "Bearer \(token)"]
        let request: RequestProtocol = RestaurantsRequest(headers: headers)

        netwokManager.makeRequest(request: request, error: .fetch, completion: completion)
    }
    
    /// Regiser user using the provided credentials.
    func register(login: String, password: String, completion: @escaping (AFResult<RestaurantsModel>) -> Void) {

        let request: RequestProtocol = RestaurantsRequest()

        netwokManager.makeRequest(request: request, error: .fetch, completion: completion)
    }
}
