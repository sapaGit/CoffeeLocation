//
//  NetworkError.swift
//  CoffeeLocation
//

import Foundation

final class NetworkError: NSObject, Error {

    // MARK: - Properties

    var type: TypeError
    var message: String?

    // MARK: - init

    init(_ type: TypeError, message: String? = nil) {
        self.type = type
        self.message = message
    }
}

