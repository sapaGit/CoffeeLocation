//
//  OrderPresenter.swift
//  CoffeeLocation
//


import Foundation

protocol OrderPresenterProtocol: BasePresenterProtocol {
    var order: [Order] { get set }

    func didTapPayButton()
    func changeOrder(id: Int, amount: Int)
    func error(typeError: TypeError)
}

final class OrderPresenter {

    // MARK: - Dependencies

    weak var view: OrderViewProtocol?
    var router: OrderRouterProtocol
    var interactor: OrderInteractorProtocol
    var order: [Order]

    // MARK: - init

    init(
        view: OrderViewProtocol,
        interactor: OrderInteractorProtocol,
        router: OrderRouterProtocol,
        order: [Order]
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.order = order
    }
}

// MARK: - Presenter Protocol

extension OrderPresenter: OrderPresenterProtocol {

    func viewDidLoad() {
        interactor.filterOrder()
        view?.didReceiveData()
    }

    func error(typeError: TypeError) {
        view?.showAlert(title: String.Order.error, message: typeError.rawValue)
    }

    func changeOrder(id: Int, amount: Int) {
        order[id].amount = amount
    }

    func didTapPayButton() {
        view?.showAlert(title: String.Order.payment, message: String.Order.paymentMessage)
    }
}
