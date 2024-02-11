//
//  RestaurantsPresenter.swift
//  CoffeeLocation
//

import Foundation

protocol RestaurantsPresenterProtocol: BasePresenterProtocol {
    var restaurants: [RestaurantsModel] { get set }

    var distances: [Int] { get set }

    var distancesString: [String] { get set }

    func didTapShowLocation()

    func didEndFetchRestaurants()

    func didEndFetchLocation()

    func didSelectRestaurant(restaurantId: Int)

    func sessionExpired()

    func error(typeError: TypeError)
}

final class RestaurantsPresenter {

    // MARK: - Properties

    var restaurants: [RestaurantsModel] = []

    var distances: [Int] = []

    var distancesString: [String] = []

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
    
    func viewDidLoad() {
        interactor.fetchRestaurants()
        view?.didReceiveData()
    }

    func didEndFetchRestaurants() {
        interactor.getDistansesFromRestaurants(restaurants: restaurants)
    }

    func didEndFetchLocation() {
        for distance in distances {
            distancesString.append(distance.formatDistance())
        }
        view?.didReceiveData()
    }
    func error(typeError: TypeError) {
        view?.showAlert(title: String.Restaurants.error, message: typeError.rawValue)
    }
    func sessionExpired() {
        router.routToLogin()
    }
    func didTapShowLocation() {
        view?.showAlert(title: String.Restaurants.mapTitle, message: String.Restaurants.mapShowError)
    }

    func didSelectRestaurant(restaurantId: Int) {
        router.routToMenu(restaurantId: restaurantId)
    }
}

