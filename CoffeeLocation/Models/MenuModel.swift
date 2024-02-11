//
//  MenuModel.swift
//  CoffeeLocation
//

import Foundation
import Alamofire

// MARK: - MenuRequest

struct MenuRequest: RequestProtocol {
    var url: String {
        "location/" + String(id) + "/menu"
    }
    let id: Int
    let method: Alamofire.HTTPMethod = .get
    var headers: HTTPHeaders?
}

// MARK: - MenuResponse

struct MenuModel: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Int
}
