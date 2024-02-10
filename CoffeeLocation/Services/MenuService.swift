//
//  MenuService.swift
//  CoffeeLocation
//

import Foundation
import Alamofire

protocol MenuServiceProtocol {

    func fetchMenu(id: Int, token: String, completion: @escaping (AFResult<[MenuModel]>) -> Void)

}

final class MenuService {

    // MARK: - Dependencies

    private let netwokManager: NetworkManagerProtocol

    // MARK: - init

    init(netwokManager: NetworkManagerProtocol) {
        self.netwokManager = netwokManager
    }
}

// MARK: - RegistrationServiceProtocol

extension MenuService: MenuServiceProtocol {

    func fetchMenu(id: Int,
                   token: String,
                   completion: @escaping (AFResult<[MenuModel]>) -> Void) {
        let headers: HTTPHeaders?  = ["Authorization": "Bearer \(token)"]
        let request: RequestProtocol = MenuRequest(id: id, headers: headers)

        netwokManager.makeRequest(request: request, error: .fetch, completion: completion)
    }
}
