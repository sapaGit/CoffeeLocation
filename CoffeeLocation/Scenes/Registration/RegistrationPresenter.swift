//
//  RegistrationPresenter.swift
//  CoffeeLocation
//


import Foundation

protocol RegistrationPresenterProtocol: BasePresenterProtocol {
    func didTapRegister(login: String, password: String)

    func didRegister()

    func error(typeError: TypeError)
}

final class RegistrationPresenter {

    // MARK: - Dependencies

    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol
    var interactor: RegistrationInteractorProtocol

    // MARK: - init

    init(view: RegistrationViewProtocol, interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Presenter Protocol

extension RegistrationPresenter: RegistrationPresenterProtocol {
    func didTapRegister(login: String, password: String) {
        interactor.register(login: login, password: password)
    }

    func didRegister() {
        router.routToLogin()
    }

    func error(typeError: TypeError) {
        view?.showAlert(message: typeError.rawValue)
    }
}

