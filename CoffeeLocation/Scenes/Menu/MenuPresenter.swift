//
//  MenuPresenter.swift
//  CoffeeLocation
//

import Foundation

protocol MenuPresenterProtocol: BasePresenterProtocol {
    var menuArray: [MenuModel] { get set }
    var orderArray: [Order] { get set }
    var restaurantId: Int { get set }

    func didEndFetchMenu()
    func didTapOpenPayment()
    func sessionExpired()
    func changeOrder(id: Int, amount: Int)
    func error(typeError: TypeError)
}

final class MenuPresenter {

    // MARK: - Properties

    var menuArray: [MenuModel] = []
    var orderArray: [Order] = []

    // MARK: - Dependencies

    weak var view: MenuViewProtocol?
    var router: MenuRouterProtocol
    var interactor: MenuInteractorProtocol
    var restaurantId: Int

    // MARK: - init

    init(
        view: MenuViewProtocol,
        interactor: MenuInteractorProtocol,
        router: MenuRouterProtocol,
        restaurantId: Int
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.restaurantId = restaurantId
    }
}

// MARK: - Presenter Protocol

extension MenuPresenter: MenuPresenterProtocol {

    func error(typeError: TypeError) {
        view?.showAlert(title: String.Menu.error, message: typeError.rawValue)
    }

    func viewDidLoad() {
        interactor.fetchMenu(id: restaurantId)
        view?.didReceiveData()
    }

    func didTapOpenPayment() {
        guard !interactor.isOrderIsEmpty() else { 
            view?.showAlert(
                title: String.Menu.error,
                message: String.Menu.addItemToOrderMessage
            )
            return
        }
        router.routToPayment(order: orderArray)
    }

    func didEndFetchMenu() {
        createOrder()
        view?.didReceiveData()
    }

    func sessionExpired() {
        router.routToLogin()
    }

    func changeOrder(id: Int, amount: Int) {
        orderArray[id].amount = amount
    }

    func createOrder() {
        for item in menuArray {
            let order = Order(
                id: item.id,
                name: item.name,
                price: item.price,
                amount: 0
            )
            orderArray.append(order)
        }
    }
}


