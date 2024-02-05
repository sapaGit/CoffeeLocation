//
//  RestaurantsPresenter.swift
//  CoffeeLocation
//

import Foundation

protocol RestaurantsPresenterProtocol: BasePresenterProtocol {
    var restaurants: [RestaurantsModel] { get set }

    var distances: [Int] { get set }

    func didTapShowLocation()

    func didEndFetchRestaurants()

    func didEndFetchLocation()

    func didLogin()
}

final class RestaurantsPresenter {

    // MARK: - Properties

    var restaurants: [RestaurantsModel] = []

    var distances: [Int] = []

    // MARK: - Dependencies

    weak var view: RestaurantsViewProtocol?
    var router: RestaurantsRouterProtocol
    var interactor: RestaurantsInteractorProtocol

    // MARK: - init

    init(view: RestaurantsViewProtocol, interactor: RestaurantsInteractorProtocol, router: RestaurantsRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Presenter Protocol

extension RestaurantsPresenter: RestaurantsPresenterProtocol {
    func didEndFetchLocation() {
       
    }
    
    func didEndFetchRestaurants() {
        view?.didReceiveData()
        interactor.getUserLocation()
    }
    

    func viewDidLoad() {
        interactor.fetchRestaurants()
    }

    func didTapShowLocation() {
        view?.showAlert(title: "Показ карты", message: "Ошибка при отображении карты")
    }

    func didLogin() {
        router.routToRestaurants()
    }
}

