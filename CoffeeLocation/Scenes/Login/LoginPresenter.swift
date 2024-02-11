//
//  LoginPresenter.swift
//  CoffeeLocation
//


import Foundation

protocol LoginPresenterProtocol: BasePresenterProtocol {
    func didTapLogin(login: String, password: String)

    func didLogin()

    func error(typeError: TypeError)
}

final class LoginPresenter {

    // MARK: - Dependencies

    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol
    var interactor: LoginInteractorProtocol

    // MARK: - init

    init(view: LoginViewProtocol, interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Presenter Protocol

extension LoginPresenter: LoginPresenterProtocol {
    func didTapLogin(login: String, password: String) {
        interactor.login(login: login, password: password)
    }

    func didLogin() {
        router.routToRestaurants()
    }

    func error(typeError: TypeError) {
        view?.showAlert(message: typeError.rawValue)
    }
}
