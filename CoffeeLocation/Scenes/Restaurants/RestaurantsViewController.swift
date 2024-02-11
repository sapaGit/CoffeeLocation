//
//  RestaurantsViewController.swift
//  CoffeeLocation
//

import UIKit
import SnapKit

private enum Constants {
    static let locationButtonInset: CGFloat = 20.0
    static let tableViewInset: CGFloat = 7.0
}

protocol RestaurantsViewProtocol: AnyObject {
    /// Notifies that new data has been received.
    func didReceiveData()

    func showAlert(title: String, message: String)

    /// Navigates to ViewController
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

final class RestaurantsViewController: BaseViewController {

    // MARK: - Properties

    private lazy var restaurantsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.register(RestaurantsTableViewCell.self, forCellReuseIdentifier: RestaurantsTableViewCell.reuseIdentifier)

        return tableView
    }()

    private lazy var showLocationButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(String.Restaurants.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(didTapShowLocation), for: .touchUpInside)

        return button
    }()

    // MARK: - Dependencies

    var presenter: RestaurantsPresenterProtocol!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        presenter.viewDidLoad()
    }

    // MARK: - Private methods

    @objc
    private func didTapShowLocation() {
        presenter.didTapShowLocation()
    }
}

// MARK: - RestaurantsViewProtocol

extension RestaurantsViewController: RestaurantsViewProtocol {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(title: String.Restaurants.closeTitle, style: .default, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func didReceiveData() {
        restaurantsTableView.reloadData()
    }
}

// MARK: - SetupSubviews

extension RestaurantsViewController {

    override func setupSubviews() {
        super.setupSubviews()

        title = String.Restaurants.title
    }

    override func embedSubviews() {
        view.addSubviews(restaurantsTableView, showLocationButton)
    }

    override func setupConstraints() {
        showLocationButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.locationButtonInset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.locationButtonInset)
        }

        restaurantsTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.tableViewInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.tableViewInset)
            $0.bottom.equalTo(showLocationButton.snp.top).inset(-Constants.tableViewInset)
        }
    }
}

// MARK: - UITableViewDelegate

extension RestaurantsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantId = presenter.restaurants[indexPath.row].id
        presenter.didSelectRestaurant(restaurantId: restaurantId)
    }
}

// MARK: - UITableViewDataSource

extension RestaurantsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let currentModel = presenter.restaurants[indexPath.row]
        let currentDescription = presenter.distancesString[indexPath.row]
        cell.configure(model: currentModel, distanceDescription: currentDescription)

        return cell
    }
}
