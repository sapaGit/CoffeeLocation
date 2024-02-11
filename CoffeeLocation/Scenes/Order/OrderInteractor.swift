//
//  OrderInteractor.swift
//  CoffeeLocation
//

import Foundation

protocol OrderInteractorProtocol {
    func filterOrder()
}

final class OrderInteractor: NSObject {

    // MARK: - Dependencies

    weak var presenter: OrderPresenterProtocol?

}

// MARK: - RestaurantsInteractorProtocol

extension OrderInteractor: OrderInteractorProtocol {
    func filterOrder() {
        presenter?.order = presenter?.order.filter { $0.amount != 0 } ?? [Order]() }
}

