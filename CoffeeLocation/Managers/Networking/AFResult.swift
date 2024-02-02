//
//  AFResult.swift
//  CoffeeLocation
//

import Foundation

enum AFResult<T: Decodable> {
    case success(T)
    case error(NetworkError)
}
