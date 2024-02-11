//
//  RestaurantsModel.swift
//  CoffeeLocation
//

import Foundation
import Alamofire

// MARK: - RestaurantsRequest

struct RestaurantsRequest: RequestProtocol {
    let url = "locations"
    let method: Alamofire.HTTPMethod = .get
    var headers: HTTPHeaders? 
}

// MARK: - RestaurantsResponse

struct RestaurantsModel: Decodable {
    let id: Int
    let name: String
    let point: Point
}

struct Point: Decodable {
    let latitude: String
    let longitude: String
}

