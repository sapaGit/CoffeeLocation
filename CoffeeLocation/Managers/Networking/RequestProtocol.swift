//
//  RequestProtocol.swift
//  CoffeeLocation
//

import Foundation
import Alamofire

// MARK: - RequestProtocol

protocol RequestProtocol {

    var url: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var params: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var baseURL: String { get }
}

extension RequestProtocol {
    var body: Data? { nil }
    var params: [String: Any]? { nil }
    var headers: HTTPHeaders? { nil }
    var encoding: ParameterEncoding { JSONEncoding.default }
    var baseURL: String { "http://147.78.66.203:3210/" }

}
